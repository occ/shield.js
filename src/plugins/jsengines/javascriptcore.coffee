###*
# JSEngine plugin for JavascriptCore JS Engine
#
# Safari
#
# @class JavascriptCore
# @extends JSEngine
###
class JavascriptCore extends JSEngine
  @pluginName: -> "javascriptcore"
  @pluginPriority: -> 10

  @isApplicable: (error) ->
    error.stack? and error.sourceURL?

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
    stackTrace.name = error.name ? ''

    lines = error.stack.split '\n'
    for i in [0...lines.length]
      matches = regexStackRecord.exec lines[i]
      continue if matches is null
      record = new StackRecord (matches[1] ? ''), matches[2], matches[3], 0
      stackTrace.addRecord record

    stackTrace

ShieldJS.registerPlugin JavascriptCore