###*
# JSEngine plugin for V8 JS Engine
#
# Google Chrome
#
# @class V8
# @extends JSEngine
###
class V8 extends JSEngine
  @pluginName: -> "v8"
  @pluginPriority: -> 11

  @isApplicable: (error) ->
    error.stack? and error.type?

  @normalizeError: (error) ->
    regexStackRecord = /// ^               # Beginning of the line
      \s*at\s+                             # Ignore uninsteresting parts
      (?:\[object Object\]\.?)?            # Ignore [object Object].
      (\S+)                                # Match[1]: Function name
      \s+
      \(                                   # parentheses around the location
        (                                  # Match[2]: URL
          (?:(?:file|https?):?/*)
          [^:]+                            # Anything until the colon
        )
        :(\d+)                             # Match[3]: Line number
        :(\d+)                             # Match[4]: Column number
      \)
      \s*                                  # Ignore trailing spaces
      $ ///                                # EOL

    stackTrace = new StackTrace
    stackTrace.message = error.message

    lines = error.stack.split '\n'

    for i in [1...lines.length]
      matches = regexStackRecord.exec lines[i]
      continue if matches is null
      record = new StackRecord matches[1], matches[2], matches[3], matches[4]
      stackTrace.addRecord record

    stackTrace

ShieldJS.registerPlugin V8