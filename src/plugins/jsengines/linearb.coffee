###
  LinearB JS Engine
  Opera 7 to 9.50
###
class LinearB extends JSEngine
  @pluginName: -> "linearb"
  @pluginPriority: -> 0

  @isApplicable: (error) ->
    error['opera#sourceloc']?

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

    lines = error.stack.split '\n'
    matches = regexErrorMessage.exec lines[0]
    stackTrace.message = matches[1] if matches is not null

    for i in [0...lines.length]
      matches = regexStackRecord.exec lines[i]
      continue if matches is null
      record = new StackRecord '?', matches[2], matches[1], 0
      record.columnNumber = error.columnNumber if i == 0
      stackTrace.addRecord record

    stackTrace
