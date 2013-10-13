###*
# Basic container for a stack frame
#
# @class StackRecord
###
class StackRecord
  ###*
  # TODO
  #
  # @constructor
  ###
  constructor: (@functionName, @location, @lineNumber, @columnNumber) ->
