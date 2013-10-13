###*
# JSEngine plugin for Chakra JS Engine
#
# Internet Explorer 9+
#
# @class Chakra
# @extends JSEngine
###
class Chakra extends JSEngine
  @pluginName: -> "chakra"
  @pluginPriority: -> 21

  @isApplicable: (error) ->
    error.number? and error.stack?

  @normalizeError: (error) ->
    # TODO
    return null

ShieldJS.registerPlugin Chakra