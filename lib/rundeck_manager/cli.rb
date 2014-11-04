require 'thor'
require 'rundeck_manager'

module RundeckManager
  class CLI
    require 'rundeck_manager/cli/commands'

    # Pass start command on to Thor. Just a convenience method to keep things
    # clean in the binary.
    def self.start(*args)
      RundeckManager::CLI::Commands.start(*args)
    end

    def self.load_config(source_path, ui)
      source = File.expand_path(source_path)
      if source.is_a?(String)
        if File.exist?(source)
          yaml = YAML.load_file(source)

          RundeckManager.configure do |config|
            config.endpoint       = yaml[:endpoint]
            config.api_token      = yaml[:api_token]
            config.user_agent     = yaml[:user_agent]
            config.yaml_path      = yaml[:yaml_path]
          end
        else
          ui.error "Config file #{source} not found"
        end
      end
    end
  end
end
