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
      Opera 10.50+
    ###
    @carakan: (error) ->
      regexForDotStackTrace = /// ^          # Beginning of the line
        (?:(Error thrown at|called from))    # Match the beginning of the line so we can skip the lines with code
        \s+line(\d+),\s+                     # Match[1]: Line number
        column\s+(\d+)\s+                    # Match[2]: Column number
        in\s+
          (?:<anonymous function:\s+)?       # Skip "<anonymous function: "
          (\S+)                              # Match[3]: Function name
          >?                                 # Ignore ">" for anonymous functions
        (?:\(.*\))\s+                        # Ignore the function signature
        in\s+
        (                                    # Match[4]: URL
          (?:(?:file|https?):?/*)
          .*
        )
        :
        $ ///                                # EOL

      regexForDotStack = /// ^               # Beginning of the line
        (?:<anonymous function:\s+)?         # Skip "<anonymous function: "
        (\S+)                                # Match[1]: Function name
        >?                                   # Ignore ">" for anonymous functions
        (?:\(.*\))\s+                        # Ignore the function signature
        @
        (                                    # Match[2]: URL
          (?:(?:file|https?):?/*)
          .*
        )
        :
        (\d+)                                # Match[3]: Line number
        $ ///                                # EOL

      stackTrace = new StackTrace
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

    ###
      IE 9+
    ###
    @chakra: (error) ->
      return null

    ###
      Opera 9.50 to 10.10
    ###
    @futhark: (error) ->
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

    ###
      Safari
    ###
    @javascriptcore: (error) ->
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
        stackTrace.addRecord record

      stackTrace

    ###
      IE 5.5 up to 9
    ###
    @jscript: (error) ->
      return null

    ###
      Opera 7 to 9.50
    ###
    @linearb: (error) ->
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

    ###
      Generates stack trace from spidermonkey's error object
      Note that the column number is only available for the first stack frame
    ###
    @spidermonkey: (error) ->
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

    ###
      Generates stack trace from v8's error object
    ###
    @v8: (error) ->
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

  @normalize: (error) ->
    if error.number?
      return Normalize.chakra error if error.stack?
      return Normalize.jscript error
    if error.stack? and error.columnNumber?
      return Normalize.spidermonkey error
    if error.stack? and error.type?
      return Normalize.v8 error
    if error.stack? and error.sourceURL?
      return Normalize.javascriptcore error
    if error['opera#sourceloc']?
      if error.stacktrace?
        return Normalize.carakan error if error.stack?
        return Normalize.futhark error
      return Normalize.linearb error

    return null
