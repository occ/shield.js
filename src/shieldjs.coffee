###*
# ShieldJS - Main Module
#
# @class ShieldJS
# @static
###
class ShieldJS
  @plugins = []
  @configuration = []

  ###*
  # Registers a plugin with ShieldJS
  # @method registerPlugin
  # @param {Plugin} Plugin to register
  ###
  @registerPlugin: (plugin) ->
    if plugin.pluginName == "?"
      throw "Trying to register a plugin with no name set"

    # TODO - Shall we enfore unique names?
    @plugins.push plugin

  ###*
  # TODO
  #
  # @method configure
  # @param {Object} configuration key value pair
  ###
  @configure: (config) ->
    # TODO - Add a way to merge configurations
    @configuration = config

  ###*
  # Returns an array of plugins for a given type, sorted by the priority
  #
  # @method findPluginsByType
  # @param {String} type of plugins
  # @return {Array} matching plugins ordered by their priorities
  ###
  @findPluginsByType: (pluginType) ->
    results = @plugins.filter (p) -> p.pluginType() == pluginType
    results.sort (a, b) -> b.pluginPriority() - a.pluginPriority()

  ###*
  # TODO
  #
  # @method findPluginByName
  # @param {String} name of the plugin
  # @return {Plugin} Plugin, if found. Otherwise null
  ###
  @findPluginByName: (name) ->
    results = @plugins.filter (p) -> p.pluginName() == name
    if results.length > 0
      results[0]
    else
      null

  ###*
  # Normalize a javascript error
  #
  # @method normalizeError
  # @param {Error} error to be normalized
  # @return {StackTrace} Normalized stack trace
  ###
  @normalizeError: (error) ->
    for engine in findPluginsByType pluginType()
      if engine.isApplicable()
        return engine.normalizeError error