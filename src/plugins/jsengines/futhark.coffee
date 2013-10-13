###
  Futhark JS Engine
  Opera 9.50 to 10.10
###
class Futhark extends JSEngine
  @pluginName: -> "futhark"
  @pluginPriority: -> 1

  @isApplicable: (error) ->
    error['opera#sourceloc']? and error.stacktrace?

  @normalizeError: (error) ->
    regexStackRecord = /// ^               # Beginning of the line
      \s+Line\s+(\d+):                     # Match[1]: Line number
      .*in\s+
      (                                    # Match[2]: URL
        (?:(?:file|https?):?/*)
        .+
      )
      $ ///                                # EOL
    regexErrorMessage = /^Statement on[^:]*: ([^\n]*)$/

    stackTrace = new StackTrace

    matches = regexErrorMessage.exec error.message
    stackTrace.message = matches[1] if matches is not null

    lines = error.stack.split '\n'
    for i in [0...lines.length]
      matches = regexStackRecord.exec lines[i]
      continue if matches is null
      record = new StackRecord '?', matches[2], matches[1], 0
      record.columnNumber = error.columnNumber if i == 0
      stackTrace.addRecord record

    stackTrace