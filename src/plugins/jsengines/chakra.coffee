###
  Chakra JS Engine
  Internet Explorer 9+
###
class Chakra extends JSEngine
  @pluginName: -> "chakra"
  @pluginPriority: -> 21

  @isApplicable: (error) ->
    error.number? and error.stack?

  @normalizeError: (error) ->
    return null
