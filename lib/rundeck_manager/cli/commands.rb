require 'rundeck_manager/cli/ui'

module RundeckManager
  class CLI
    class Commands < Thor
      Dir[File.expand_path('../commands/*.rb', __FILE__)].each { |f| require f }

      def initialize(*args)
        super
        RundeckManager::CLI.load_config(options[:config], ui)
      end

      class_option :config,
                   :default => '~/.rundeck_manager.yml',
                   :type    => :string,
                   :banner  => '/path/to/config.yml'

      package_name('Rundeck Manager')

      map '-v' => 'version'
      map '--version' => 'version'

      desc "version", "print version"
      long_desc 'Print the Rundeck Manager version'
      def version
        ui.info "Rundeck Manager version %s" % [RundeckManager::VERSION]
      end

      no_commands do
        def ui
          @ui ||= if STDOUT.tty?
                    RundeckManager::CLI::UI::Color.new
                  else
                    RundeckManager::CLI::UI::Basic.new
                  end
        end
      end
    end
  end
end
