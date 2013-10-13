###
  JScript JS Engine
  Internet Explorer 5.5 to 8
###
class JScript extends JSEngine
  @pluginName: -> "jscript"
  @pluginPriority: -> 20

  @isApplicable: (error) ->
    error.number?

  @normalizeError: (error) ->
    return null
