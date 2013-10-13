###
  Basic object to contain stack trace.
###
class StackTrace
  message = null
  mode = null
  name = null
  records = null
  url = null
  userAgent = null

  constructor: ->
    @records = []
    @userAgent = navigator?.userAgent

  addRecord: (record) ->
    @records.push record

  getRecords: ->
    @records
