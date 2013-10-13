###*
# Normalized stack trace
#
# @class StackTrace
###
class StackTrace
  message = null
  mode = null
  name = null
  records = null
  url = null
  userAgent = null

  ###*
  # TODO
  #
  # @constructor
  # @param {String} Mode - Plugin used to generate the stack trace
  ###
  constructor: (@mode) ->
    @records = []
    @userAgent = navigator?.userAgent

  ###*
  # TODO
  #
  # @method addRecord
  # @param {StackRecord} stack record
  ###
  addRecord: (record) ->
    @records.push record

  ###*
  # Gets stack records in the stack trace
  #
  # @method getRecords
  # @return {StackRecord[]} array of stack records in the stack trace
  ###
  getRecords: ->
    @records
