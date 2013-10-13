###*
# JSEngine plugin for Carakan JS Engine
#
# Opera 10.50+
#
# @class Carakan
# @extends JSEngine
###
class Carakan extends JSEngine
  @pluginName: -> "carakan"
  @pluginPriority: -> 0

  @isApplicable: (error) ->
    error['opera#sourceloc']? and error.stacktrace? and error.stack?

  @normalizeError: (error) ->
    regexForDotStackTrace = /// ^          # Beginning of the line
      (?:(Error.thrown.at|called.from))    # Match the beginning of the line so we can skip the lines with code
      \s+line\s+(\d+),\s+                     # Match[1]: Line number
      column\s+(\d+)\s+                    # Match[2]: Column number
      in\s+
        (?:<anonymous.function:\s+)?       # Skip "<anonymous function: "
        (\S+)                              # Match[3]: Function name
        >?                                 # Ignore ">" for anonymous functions
      (?:\(.*\))\s*                        # Ignore the function signature
      in\s+
      (                                    # Match[4]: URL
        (?:(?:file|https?):?/*)
        .*
      )
      :
      $ ///                                # EOL

    regexForDotStack = /// ^               # Beginning of the line
      (?:                                  # Function name may or may not exist
        (?:<anonymous.function:\s+)?       # Skip "<anonymous function: "
        (\S+)                              # Match[1]: Function name
        >?                                 # Ignore ">" for anonymous functions
        (?:\(.*\))\s*                      # Ignore the function signature
      )?
      @
      (                                    # Match[2]: URL
        (?:(?:file|https?):?/*)
        .*
      )
      :
      (\d+)                                # Match[3]: Line number
      $ ///                                # EOL

    stackTrace = new StackTrace @pluginName()
    stackTrace.message = error.message

    lines = error.stacktrace.split '\n'

    if error.stack == error.stacktrace
      for i in [0...lines.length]
        matches = regexForDotStack.exec lines[i]
        continue if matches is null
        record = new StackRecord matches[1], matches[2], matches[3], 0
        stackTrace.addRecord record
    else
      for i in [0...lines.length]
        matches = regexForDotStackTrace.exec lines[i]
        continue if matches is null
        record = new StackRecord matches[3], matches[4], matches[1], matches[2]
        stackTrace.addRecord record

    stackTrace

ShieldJS.registerPlugin Carakan