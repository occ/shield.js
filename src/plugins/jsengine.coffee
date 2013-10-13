class JSEngine extends Plugin
  @pluginType: -> "jsengine"
  @pluginName: -> "?" #Throw exception instead?
  @pluginPriority: -> 0

  @normalizeError: (error) -> null

  ###
    Returns true if the plugin should be used with the current JS Engine
    Note that there can be more than one plugin returning true. In that case the plugin with the highest priority will be used
  ###
  @isApplicable: (error) -> false