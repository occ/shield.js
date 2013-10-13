module 'Chakra'
test 'Normalize IE 10 Errors', ->
  error =
    message: "Unable to get property 'undef' of undefined or null reference"
    name: "TypeError"
    stack: "TypeError: Unable to get property 'undef' of undefined or null reference\n" +
      "   at Anonymous function (http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html:48:13)\n" +
      "   at dumpException3 (http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html:46:9)\n" +
      "   at onclick (http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html:82:1)"
    description: "Unable to get property 'undef' of undefined or null reference"
    number: -2146823281

  ok Chakra.isApplicable error
  stackTrace = Chakra.normalizeError error

  equal stackTrace.mode, 'chakra', 'Mode is set to chakra'
  equal stackTrace.message, error.message, 'Message is parsed correctly'
  equal stackTrace.name, error.name, 'Name is parsed correctly'
  equal stackTrace.url, window.location.href, 'URL is set correctly' if window? and window.location?
  equal stackTrace.userAgent, navigator.userAgent, 'User Agent is set correctly' if navigator?

  stackRecords = stackTrace.getRecords()
  equal stackRecords.length, 3, 'Stack Trace has 3 Stack Records'

  record = stackRecords[0]
  equal record.functionName, 'Anonymous function'
  equal record.location, 'http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html'
  equal record.lineNumber, '48'
  equal record.columnNumber, '13'

  record = stackRecords[1]
  equal record.functionName, 'dumpException3'
  equal record.location, 'http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html'
  equal record.lineNumber, '46'
  equal record.columnNumber, '9'

  record = stackRecords[2]
  equal record.functionName, 'onclick'
  equal record.location, 'http://jenkins.eriwen.com/job/stacktrace.js/ws/test/functional/ExceptionLab.html'
  equal record.lineNumber, '82'
  equal record.columnNumber, '1'
