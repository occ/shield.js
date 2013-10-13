module 'SpiderMonkey'
test 'Normalize Firefox 22 Errors', ->
  error =
    message: "x is null"
    name: "TypeError"
    stack: "@file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:4\n" +
    "createException@file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:8\n" +
    "createException4@file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:56\n" +
    "dumpException4@file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:60\n" +
    "onclick@file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:1\n" +
    ""
    fileName: "file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js"
    lineNumber: 4
    columnNumber: 6

  ok SpiderMonkey.isApplicable error
  stackTrace = SpiderMonkey.normalizeError error

  equal stackTrace.mode, 'spidermonkey', 'Mode is set to spidermonkey'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 5, 'Stack Trace has 5 Stack Records'

  record = stackRecords[0]
  equal record.functionName, ''
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '4'
  equal record.columnNumber, '6'

  record = stackRecords[1]
  equal record.functionName, 'createException'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '8'
  equal record.columnNumber, '0'

  record = stackRecords[2]
  equal record.functionName, 'createException4'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '56'
  equal record.columnNumber, '0'

  record = stackRecords[3]
  equal record.functionName, 'dumpException4'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '60'
  equal record.columnNumber, '0'

  record = stackRecords[4]
  equal record.functionName, 'onclick'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '1'
  equal record.columnNumber, '0'

test 'Normalize Firefox 14 Errors', ->
  error =
    message: "x is null",
    stack: "@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:48\n" +
      "dumpException3@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:52\n" +
      "onclick@file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html:1\n" +
      "",
    fileName: "file:///Users/eric/src/javascript-stacktrace/test/functional/ExceptionLab.html",
    lineNumber: 48

  ok SpiderMonkey.isApplicable error
  stackTrace = SpiderMonkey.normalizeError error

  equal stackTrace.mode, 'spidermonkey', 'Mode is set to spidermonkey'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 3, 'Stack Trace has 3 Stack Records'

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
  equal record.lineNumber, '1'
  equal record.columnNumber, '0'
