###*
# JSEngine plugin for SpiderMonkey JS Engine
#
# Mozilla Applications
#
# NOTE The column number is only available for the first stack frame
#
# @class SpiderMonkey
# @extends JSEngine
###
class SpiderMonkey extends JSEngine
  @pluginName: -> "spidermonkey"
  @pluginPriority: -> 12

  @isApplicable: (error) ->
    error.stack? and error.columnNumber?

  @normalizeError: (error) ->
    regexStackRecord = /// ^               # Beginning of the line
      (\S+)?                               # Match[1]: Function name
      @
      (                                    # Match[2]: URL
        (?:(?:file|https?):?/*)
        .+                                 # Anything
      )
      :(\d+)                               # Match[3]: Line number
      \s*                                  # Ignore trailing spaces
      $ ///                                # EOL

    stackTrace = new StackTrace @pluginName()
    stackTrace.message = error.message
    stackTrace.name = error.name if error.name?

    lines = error.stack.split '\n'
    for i in [0...lines.length]
      matches = regexStackRecord.exec lines[i]
      continue if matches is null
      record = new StackRecord (matches[1] ? ''), matches[2], matches[3], 0
      record.columnNumber = (error.columnNumber if i == 0 and error.columnNumber?) ? 0
      stackTrace.addRecord record

    stackTrace

ShieldJS.registerPlugin SpiderMonkey