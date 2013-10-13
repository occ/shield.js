module 'JavascriptCore'
test 'Normalize JavascriptCore Errors', ->
  error =
    message: "'null' is not an object (evaluating 'x.undef')"
    stack: "@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:48\n" +
      "dumpException3@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:52\n" +
      "onclick@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:82\n" +
      "[native code]"
    line: 48
    sourceURL: "file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html"

  ok JavascriptCore.isApplicable error
  stackTrace = JavascriptCore.normalizeError error

  equal stackTrace.mode, 'javascriptcore', 'Mode is set to javascriptcore'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, '', 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 3, 'Stack Trace has 5 Stack Records'

  record = stackRecords[0]
  equal record.functionName, ''
  equal record.location, 'file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '48'
  equal record.columnNumber, '0'

  record = stackRecords[1]
  equal record.functionName, 'dumpException3'
  equal record.location, 'file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '52'
  equal record.columnNumber, '0'

  record = stackRecords[2]
  equal record.functionName, 'onclick'
  equal record.location, 'file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '82'
  equal record.columnNumber, '0'

