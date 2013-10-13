module 'LinearB'
test 'Normalize Opera 8.54 Errors', ->
  error =
    message: "Statement on line 44: Type mismatch (usually a non-object value used where an object is required)\n" +
      "Backtrace:\n" +
      "  Line 44 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    this.undef();\n" +
      "  Line 31 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    ex = ex || this.createException();\n" +
      "  Line 18 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    var p = new printStackTrace.implementation(), result = p.run(ex);\n" +
      "  Line 4 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    printTrace(printStackTrace());\n" +
      "  Line 7 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(n - 1);\n" +
      "  Line 11 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(2);\n" +
      "  Line 15 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    foo();\n" +
      ""
    'opera#sourceloc': 44

  ok LinearB.isApplicable error
  stackTrace = LinearB.normalizeError error

  equal stackTrace.mode, 'linearb', 'Mode is set to linearb'
  equal stackTrace.message, 'Type mismatch (usually a non-object value used where an object is required)', 'Message is parsed correctly'
  equal stackTrace.name, '', 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 7, 'Stack Trace has 7 Stack Records'

  record = stackRecords[0]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '44'
  equal record.columnNumber, ''

  record = stackRecords[1]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '31'
  equal record.columnNumber, ''

  record = stackRecords[2]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '18'
  equal record.columnNumber, ''

  record = stackRecords[3]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '4'
  equal record.columnNumber, ''

  record = stackRecords[4]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '7'
  equal record.columnNumber, ''

  record = stackRecords[5]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '11'
  equal record.columnNumber, ''

  record = stackRecords[6]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '15'
  equal record.columnNumber, ''

test 'Normalize Opera 9.02 Errors', ->
  error =
    message: "Statement on line 44: Type mismatch (usually a non-object value used where an object is required)\n" +
      "Backtrace:\n" +
      "  Line 44 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    this.undef();\n" +
      "  Line 31 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    ex = ex || this.createException();\n" +
      "  Line 18 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    var p = new printStackTrace.implementation(), result = p.run(ex);\n" +
      "  Line 4 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    printTrace(printStackTrace());\n" +
      "  Line 7 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(n - 1);\n" +
      "  Line 11 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(2);\n" +
      "  Line 15 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    foo();\n" +
      ""
    'opera#sourceloc': 44

  ok LinearB.isApplicable error
  stackTrace = LinearB.normalizeError error

  equal stackTrace.mode, 'linearb', 'Mode is set to linearb'
  equal stackTrace.message, 'Type mismatch (usually a non-object value used where an object is required)', 'Message is parsed correctly'
  equal stackTrace.name, '', 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 7, 'Stack Trace has 7 Stack Records'

  record = stackRecords[0]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '44'
  equal record.columnNumber, ''

  record = stackRecords[1]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '31'
  equal record.columnNumber, ''

  record = stackRecords[2]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '18'
  equal record.columnNumber, ''

  record = stackRecords[3]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '4'
  equal record.columnNumber, ''

  record = stackRecords[4]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '7'
  equal record.columnNumber, ''

  record = stackRecords[5]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '11'
  equal record.columnNumber, ''

  record = stackRecords[6]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '15'
  equal record.columnNumber, ''

test 'Normalize Opera 9.27 Errors', ->
  error =
    message: "Statement on line 43: Type mismatch (usually a non-object value used where an object is required)\n" +
      "Backtrace:\n" +
      "  Line 43 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    this.undef();\n" +
      "  Line 31 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    ex = ex || this.createException();\n" +
      "  Line 18 of linked script file://localhost/G:/js/stacktrace.js\n" +
      "    var p = new printStackTrace.implementation(), result = p.run(ex);\n" +
      "  Line 4 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    printTrace(printStackTrace());\n" +
      "  Line 7 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(n - 1);\n" +
      "  Line 11 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    bar(2);\n" +
      "  Line 15 of inline#1 script in file://localhost/G:/js/test/functional/testcase1.html\n" +
      "    foo();\n" +
      ""
    'opera#sourceloc': 43

  ok LinearB.isApplicable error
  stackTrace = LinearB.normalizeError error

  equal stackTrace.mode, 'linearb', 'Mode is set to linearb'
  equal stackTrace.message, 'Type mismatch (usually a non-object value used where an object is required)', 'Message is parsed correctly'
  equal stackTrace.name, '', 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 7, 'Stack Trace has 7 Stack Records'

  record = stackRecords[0]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '43'
  equal record.columnNumber, ''

  record = stackRecords[1]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '31'
  equal record.columnNumber, ''

  record = stackRecords[2]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/stacktrace.js'
  equal record.lineNumber, '18'
  equal record.columnNumber, ''

  record = stackRecords[3]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '4'
  equal record.columnNumber, ''

  record = stackRecords[4]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '7'
  equal record.columnNumber, ''

  record = stackRecords[5]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '11'
  equal record.columnNumber, ''

  record = stackRecords[6]
  equal record.functionName, ''
  equal record.location, 'file://localhost/G:/js/test/functional/testcase1.html'
  equal record.lineNumber, '15'
  equal record.columnNumber, ''
