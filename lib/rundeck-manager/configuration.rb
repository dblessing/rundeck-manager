module RundeckManager
  # Defines constants and methods related to configuration.
  module Configuration
    VALID_OPTIONS_KEYS = [:yaml_path]

    VALID_RD_OPTIONS_KEYS = Rundeck::Configuration::VALID_OPTIONS_KEYS

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield self
    end

    # Creates a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.reduce({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Resets all configuration options to the defaults.
    def reset
      self.api_token = ENV['RDM_YAML_PATH']
      Rundeck.reset
    end

    # Pass Rundeck Gem Options through
    VALID_RD_OPTIONS_KEYS.each do |key|
      class_eval %{
        def #{key}
          Rundeck.#{key}
        end

        def #{key}=(value)
          Rundeck.#{key} = value
        end
      }
    end
  end
end
