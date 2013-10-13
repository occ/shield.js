###*
# Base class for Plugins
#
# @class Plugin
###
class Plugin
  ###*
  # Plugin Type
  #
  # @method pluginType
  # @return {String} Type of the plugin
  ###
  pluginType: -> ""

  ###*
  # Plugin Type
  #
  # @method pluginType
  # @return {String} Type of the plugin
  ###
  pluginName: -> "?" #Throw exception instead?

  ###*
  # Returns the plugin priority
  #
  # Plugins with higher priorities will be executed/given the opportunity first
  #
  # @method pluginPriority
  # @return {Int} Priority of the plugin
  ###
  pluginPriority: -> 0
