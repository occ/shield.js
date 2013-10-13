module 'V8'
test 'Normalize Chrome 15 Errors', ->
  error =
    arguments: ["undef"]
    message: "Object #<Object> has no method 'undef'"
    stack: "TypeError: Object #<Object> has no method 'undef'\n" +
      "    at Object.createException (http://127.0.0.1:8000/js/stacktrace.js:42:18)\n" +
      "    at Object.run (http://127.0.0.1:8000/js/stacktrace.js:31:25)\n" +
      "    at printStackTrace (http://127.0.0.1:8000/js/stacktrace.js:18:62)\n" +
      "    at bar (http://127.0.0.1:8000/js/test/functional/testcase1.html:13:17)\n" +
      "    at bar (http://127.0.0.1:8000/js/test/functional/testcase1.html:16:5)\n" +
      "    at foo (http://127.0.0.1:8000/js/test/functional/testcase1.html:20:5)\n" +
      "    at http://127.0.0.1:8000/js/test/functional/testcase1.html:24:4"

  ok V8.isApplicable error
  stackTrace = V8.normalizeError error

  equal stackTrace.mode, 'v8', 'Mode is set to v8'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 7, 'Stack Trace has 7 Stack Records'

  record = stackRecords[0]
  equal record.functionName, 'Object.createException'
  equal record.location, 'http://127.0.0.1:8000/js/stacktrace.js'
  equal record.lineNumber, '42'
  equal record.columnNumber, '18'

  record = stackRecords[1]
  equal record.functionName, 'Object.run'
  equal record.location, 'http://127.0.0.1:8000/js/stacktrace.js'
  equal record.lineNumber, '31'
  equal record.columnNumber, '25'

  record = stackRecords[2]
  equal record.functionName, 'printStackTrace'
  equal record.location, 'http://127.0.0.1:8000/js/stacktrace.js'
  equal record.lineNumber, '18'
  equal record.columnNumber, '62'

  record = stackRecords[3]
  equal record.functionName, 'bar'
  equal record.location, 'http://127.0.0.1:8000/js/test/functional/testcase1.html'
  equal record.lineNumber, '13'
  equal record.columnNumber, '17'

  record = stackRecords[4]
  equal record.functionName, 'bar'
  equal record.location, 'http://127.0.0.1:8000/js/test/functional/testcase1.html'
  equal record.lineNumber, '16'
  equal record.columnNumber, '5'

  record = stackRecords[5]
  equal record.functionName, 'foo'
  equal record.location, 'http://127.0.0.1:8000/js/test/functional/testcase1.html'
  equal record.lineNumber, '20'
  equal record.columnNumber, '5'

  record = stackRecords[6]
  equal record.functionName, ''
  equal record.location, 'http://127.0.0.1:8000/js/test/functional/testcase1.html'
  equal record.lineNumber, '24'
  equal record.columnNumber, '4'

test 'Normalize Chrome 27 Errors', ->
  error =
    message: "Cannot call method 'undef' of null"
    name: "TypeError"
    stack: "TypeError: Cannot call method 'undef' of null\n" +
    " at file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:4:9\n" +
    " at createException (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:8:5)\n" +
    " at createException4 (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:56:16)\n" +
    " at dumpException4 (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:60:23)\n" +
    " at HTMLButtonElement.onclick (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:83:126)"

  ok V8.isApplicable error
  stackTrace = V8.normalizeError error

  equal stackTrace.mode, 'v8', 'Mode is set to v8'
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
  equal record.columnNumber, '9'

  record = stackRecords[1]
  equal record.functionName, 'createException'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '8'
  equal record.columnNumber, '5'

  record = stackRecords[2]
  equal record.functionName, 'createException4'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '56'
  equal record.columnNumber, '16'

  record = stackRecords[3]
  equal record.functionName, 'dumpException4'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '60'
  equal record.columnNumber, '23'

  record = stackRecords[4]
  equal record.functionName, 'HTMLButtonElement.onclick'
  equal record.location, 'file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '83'
  equal record.columnNumber, '126'
