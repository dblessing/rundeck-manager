require 'rundeck'
require 'rundeck-manager/configuration'
require 'rundeck-manager/objects'
require 'rundeck-manager/version'

module RundeckManager
  extend Configuration

  include Objects

  # @private
  attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

  def initialize(options = {})
    options = RundeckManager.options.merge(options)
    opt_keys = Configuration::VALID_OPTIONS_KEYS
        .concat(Configuration::VALID_RD_OPTIONS_KEYS)

    opt_keys.each do |key|
      send("#{key}=", options[key]) if options.has_key?(key)
    end
  end
end
