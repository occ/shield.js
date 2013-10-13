class ShieldJS
  @plugins = []
  @configuration = []

  @registerPlugin: (plugin) ->
    if plugin.pluginName == "?"
      throw "Trying to register a plugin with no name set"

    # TODO - Shall we enfore unique names?
    @plugins.push plugin

  @configure: (config) ->
    # TODO - Add a way to merge configurations
    @configuration = config

  @findPluginsByType: (pluginType) ->
    results = @plugins.filter (p) -> p.pluginType() == pluginType
    results.sort (a, b) -> b.pluginPriority() - a.pluginPriority()

  @findPluginByName: (name) ->
    results = @plugins.filter (p) -> p.pluginName() == name
    results[0]

  @normalizeError: (error) ->
    for engine in findPluginsByType pluginType()
      if engine.isApplicable()
        return engine.normalize error