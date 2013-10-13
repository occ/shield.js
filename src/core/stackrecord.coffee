###
  Basic container for a stack frame.
###
class StackRecord
  columnNumber = null
  functionName = null
  lineNumber = null
  location = null

  constructor: (@functionName, @location, @lineNumber, @columnNumber) ->
