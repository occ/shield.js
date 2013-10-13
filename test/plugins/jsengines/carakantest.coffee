module 'Carakan'
test 'Normalize Opera 12.16 Error', ->
  error =
    message: "Cannot convert 'x' to object"
    name: "TypeError"
    stack: "<anonymous function>([arguments not available])@http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js:4\n" +
      "createException([arguments not available])@http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js:2\n" +
      "createException4([arguments not available])@http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:56\n" +
      "dumpException4([arguments not available])@http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:60\n" +
      "<anonymous function>([arguments not available])@http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:1"
    stacktrace: "Error thrown at line 4, column 6 in <anonymous function>(x) in http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js:\n" +
      "    x.undef();\n" +
      "called from line 2, column 2 in createException() in http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js:\n" +
      "    return ((function(x) {\n" +
      "called from line 56, column 8 in createException4() in http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:\n" +
      "    return createException();\n" +
      "called from line 60, column 8 in dumpException4() in http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:\n" +
      "    dumpException(createException4());\n" +
      "called from line 1, column 0 in <anonymous function>(event) in http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html:\n" +
      "    dumpException4();"

  ok Carakan.isApplicable error
  stackTrace = Carakan.normalizeError error

  equal stackTrace.mode, 'carakan', 'Mode is set to carakan'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 5, 'Stack Trace has 5 Stack Records'

  record = stackRecords[0]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '4'
  equal record.columnNumber, '18'

  record = stackRecords[1]
  equal record.functionName, 'createException'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '2'
  equal record.columnNumber, '25'

  record = stackRecords[2]
  equal record.functionName, 'createException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '56'
  equal record.columnNumber, '62'

  record = stackRecords[3]
  equal record.functionName, 'dumpException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '60'
  equal record.columnNumber, '17'

  record = stackRecords[4]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '1'
  equal record.columnNumber, '5'

test 'Normalize Opera 11.51 Error', ->
  error =
    message: "'this.undef' is not a function",
    stack: "<anonymous function: createException>([arguments not available])@file://localhost/G:/js/stacktrace.js:42\n" +
      "<anonymous function: run>([arguments not available])@file://localhost/G:/js/stacktrace.js:27\n" +
      "printStackTrace([arguments not available])@file://localhost/G:/js/stacktrace.js:18\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:4\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:7\n" +
      "foo([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:11\n" +
      "@file://localhost/G:/js/test/functional/testcase1.html:15",
    stacktrace: "Error thrown at line 42, column 12 in <anonymous function: createException>() in file://localhost/G:/js/stacktrace.js:\n" +
      "    this.undef();\n" +
      "called from line 27, column 8 in <anonymous function: run>(ex) in file://localhost/G:/js/stacktrace.js:\n" +
      "    ex = ex || this.createException();\n" +
      "called from line 18, column 4 in printStackTrace(options) in file://localhost/G:/js/stacktrace.js:\n" +
      "    var p = new printStackTrace.implementation(), result = p.run(ex);\n" +
      "called from line 4, column 5 in bar(n) in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    printTrace(printStackTrace());\n" +
      "called from line 7, column 4 in bar(n) in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    bar(n - 1);\n" +
      "called from line 11, column 4 in foo() in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    bar(2);\n" +
      "called from line 15, column 3 in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    foo();"

  ok Carakan.isApplicable error
  stackTrace = Carakan.normalizeError error

  equal stackTrace.mode, 'carakan', 'Mode is set to carakan'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 5, 'Stack Trace has 5 Stack Records'

  record = stackRecords[0]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '4'
  equal record.columnNumber, '18'

  record = stackRecords[1]
  equal record.functionName, 'createException'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '2'
  equal record.columnNumber, '25'

  record = stackRecords[2]
  equal record.functionName, 'createException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '56'
  equal record.columnNumber, '62'

  record = stackRecords[3]
  equal record.functionName, 'dumpException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '60'
  equal record.columnNumber, '17'

  record = stackRecords[4]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '1'
  equal record.columnNumber, '5'

test 'Normalize Opera 11.11 Error', ->
  error =
    message: "'this.undef' is not a function",
    stack: "<anonymous function: createException>([arguments not available])@file://localhost/G:/js/stacktrace.js:42\n" +
      "<anonymous function: run>([arguments not available])@file://localhost/G:/js/stacktrace.js:27\n" +
      "printStackTrace([arguments not available])@file://localhost/G:/js/stacktrace.js:18\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:4\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:7\n" +
      "foo([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:11\n" +
      "@file://localhost/G:/js/test/functional/testcase1.html:15",
    stacktrace: "Error thrown at line 42, column 12 in <anonymous function: createException>() in file://localhost/G:/js/stacktrace.js:\n" +
      "    this.undef();\n" +
      "called from line 27, column 8 in <anonymous function: run>(ex) in file://localhost/G:/js/stacktrace.js:\n" +
      "    ex = ex || this.createException();\n" +
      "called from line 18, column 4 in printStackTrace(options) in file://localhost/G:/js/stacktrace.js:\n" +
      "    var p = new printStackTrace.implementation(), result = p.run(ex);\n" +
      "called from line 4, column 5 in bar(n) in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    printTrace(printStackTrace());\n" +
      "called from line 7, column 4 in bar(n) in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    bar(n - 1);\n" +
      "called from line 11, column 4 in foo() in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    bar(2);\n" +
      "called from line 15, column 3 in file://localhost/G:/js/test/functional/testcase1.html:\n" +
      "    foo();"

  ok Carakan.isApplicable error
  stackTrace = Carakan.normalizeError error

  equal stackTrace.mode, 'carakan', 'Mode is set to carakan'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 5, 'Stack Trace has 5 Stack Records'

  record = stackRecords[0]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '4'
  equal record.columnNumber, '18'

  record = stackRecords[1]
  equal record.functionName, 'createException'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.js'
  equal record.lineNumber, '2'
  equal record.columnNumber, '25'

  record = stackRecords[2]
  equal record.functionName, 'createException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '56'
  equal record.columnNumber, '62'

  record = stackRecords[3]
  equal record.functionName, 'dumpException4'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '60'
  equal record.columnNumber, '17'

  record = stackRecords[4]
  equal record.functionName, '<anonymous function>'
  equal record.location, 'http://localhost:63342/javascript-stacktrace/test/functional/ExceptionLab.html'
  equal record.lineNumber, '1'
  equal record.columnNumber, '5'

test 'Normalize Opera 10.63 Error', ->
  error =
    message: "'this.undef' is not a function",
    stack: "<anonymous function: createException>([arguments not available])@file://localhost/G:/js/stacktrace.js:42\n" +
      "<anonymous function: run>([arguments not available])@file://localhost/G:/js/stacktrace.js:27\n" +
      "printStackTrace([arguments not available])@file://localhost/G:/js/stacktrace.js:18\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:4\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:7\n" +
      "foo([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:11\n" +
      "@file://localhost/G:/js/test/functional/testcase1.html:15",
    stacktrace: "<anonymous function: createException>([arguments not available])@file://localhost/G:/js/stacktrace.js:42\n" +
      "<anonymous function: run>([arguments not available])@file://localhost/G:/js/stacktrace.js:27\n" +
      "printStackTrace([arguments not available])@file://localhost/G:/js/stacktrace.js:18\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:4\n" +
      "bar([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:7\n" +
      "foo([arguments not available])@file://localhost/G:/js/test/functional/testcase1.html:11\n" +
      "@file://localhost/G:/js/test/functional/testcase1.html:15"

  ok Carakan.isApplicable error
  stackTrace = Carakan.normalizeError error

  equal stackTrace.mode, 'carakan', 'Mode is set to carakan'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 7, 'Stack Trace has 7 Stack Records'

  record = stackRecords[0]
  equal record.functionName, 'createException'
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '42'
  equal record.columnNumber, '0'

  record = stackRecords[1]
  equal record.functionName, 'run'
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '27'
  equal record.columnNumber, '0'

  record = stackRecords[2]
  equal record.functionName, 'printStackTrace'
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '18'
  equal record.columnNumber, '0'

  record = stackRecords[3]
  equal record.functionName, 'bar'
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '4'
  equal record.columnNumber, '0'

  record = stackRecords[4]
  equal record.functionName, 'bar'
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '7'
  equal record.columnNumber, '0'

  record = stackRecords[5]
  equal record.functionName, 'foo'
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '11'
  equal record.columnNumber, '0'

  record = stackRecords[6]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '15'
  equal record.columnNumber, '0'

