###*
# Base Javascript Engine Plugin
#
# @class JSEngine
# @extends Plugin
###
class JSEngine extends Plugin
  @pluginType: -> "jsengine"

  ###*
  # Generate a StackTrace object from a given Error
  #
  # @method normalizeError
  # @param {Error} error object
  # @return {StackTrace} normalized stack trace
  ###
  #noinspection CoffeeScriptUnusedLocalSymbols
  @normalizeError: (error) -> null

  ###*
  # Returns true if the plugin should be used with the current JS Engine
  # Note that there can be more than one plugin returning true. In that case the plugin with the highest priority will be used
  #
  # @method isApplicable
  # @param {Error} error
  # @return {Boolean} true if the plugin can be used to process the error object
  ###
  #noinspection CoffeeScriptUnusedLocalSymbols
  @isApplicable: (error) -> false