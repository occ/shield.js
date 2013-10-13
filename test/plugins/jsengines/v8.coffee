module 'V8'
test 'Normalize', ->
  error =
    message: "Cannot call method 'undef' of null",
    name: "TypeError",
    stack: "TypeError: Cannot call method 'undef' of null\n" +
      " at file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:4:9\n" +
      " at createException (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.js:8:5)\n" +
      " at createException4 (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:56:16)\n" +
      " at dumpException4 (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:60:23)\n" +
      " at HTMLButtonElement.onclick (file:///E:/javascript-stacktrace/test/functional/ExceptionLab.html:83:126)"
  stackTrace = V8.normalizeError error

  equal stackTrace.message, error.message
  equal stackTrace.mode, 'monkeys'

  ok true, stackTrace
