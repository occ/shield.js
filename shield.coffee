###
  Basic object to contain stack trace.
###
class StackTrace
  message = null
  mode = null
  name = null
  records = null
  url = null
  userAgent = null

  constructor: ->
    @records = []
    @userAgent = navigator?.userAgent

  addRecord: (record) ->
    @records.push record

  getRecords: ->
    @records

###
  Basic container for a stack frame.
###
class StackRecord
  columnNumber = null
  functionName = null
  lineNumber = null
  location = null

  constructor: (@functionName, @location, @lineNumber, @columnNumber) ->

class ShieldJS
  class Normalize
    ###
      Generates stack trace from v8's error object
    ###
    v8: (error) ->
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

    ###
      Generates stack trace from gecko's error object
      Note that gecko reports the column number only for the first stack frame
    ###
    gecko: (error) ->
      regexStackRecord = /// ^               # Beginning of the line
        (\S+)                                # Match[1]: Function name
        @
        (                                    # Match[2]: URL
          (?:(?:file|https?):?/*)
          [^:]+                              # Anything until the colon
        )
        :(\d+)                               # Match[3]: Line number
        \s*                                  # Ignore trailing spaces
        $ ///                                # EOL

      stackTrace = new StackTrace
      stackTrace.message = error.message

      lines = error.stack.split '\n'
      for i in [0...lines.length]
        matches = regexStackRecord.exec lines[i]
        continue if matches is null
        record = new StackRecord matches[1], matches[2], matches[3], 0
        record.columnNumber = error.columnNumber if i == 0
        stackTrace.addRecord record

      stackTrace

  normalizer = null
  constructor: ->
    @normalizer = new Normalize

  normalize: (error) ->
    if error.stack? and error.columnNumber
      return @normalizer.gecko error
    if error.stack? and error.type?
      return @normalizer.v8 error

    return null
