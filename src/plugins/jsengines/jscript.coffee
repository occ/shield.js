###*
# JSEngine plugin for JScript JS Engine
#
# Internet Explorer 5.5 to 8
#
# @class JScript
# @extends JSEngine
###
class JScript extends JSEngine
  @pluginName: -> "jscript"
  @pluginPriority: -> 20

  @isApplicable: (error) ->
    error.number?

  @normalizeError: (error) ->
    # TODO
    return null

ShieldJS.registerPlugin JScript