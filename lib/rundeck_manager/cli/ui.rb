require 'thor/shell/basic'
require 'thor/shell/color'

## Concepts borrowed from Vagrant UI class.

module RundeckManager
  class CLI
    module UI
      class Basic
        def initialize
          @shell = Thor::Shell::Basic.new
        end

        # Use some light meta-programming to create the various methods to
        # output text to the UI. These all delegate the real functionality
        # to `say`.
        [:info, :warn, :error, :success].each do |method|
          class_eval <<-CODE
              def #{method}(message)
                @shell.say(message)
              end
          CODE
        end

        def ask(message, opts=nil)
          @shell.ask message
        end

        def yes?(message, color=nil)
          @shell.yes? message, color
        end

        def handle_error(e, trace=false)
          error e.message

          if trace
            e.backtrace.each do |line|
              error line, :white
            end
          end
        end
      end

      class Color < Basic
        def initialize
          @shell = Thor::Shell::Color.new
        end

        # Terminal colors
        COLORS = {
            :clear  => "\e[0m",
            :red    => "\e[31m",
            :green  => "\e[32m",
            :yellow => "\e[33m"
        }

        # Mapping between type of message and the color to output
        COLOR_MAP = {
            :info    => nil,
            :warn    => :yellow,
            :error   => :red,
            :success => :green
        }

        # Use some light meta-programming to create the various methods to
        # output text to the UI. These all delegate the real functionality
        # to `say`.
        [:info, :warn, :error, :success].each do |method|
          class_eval <<-CODE
              def #{method}(message,color=nil,force_new_line = (message.to_s !~ /( |\t)\Z/))
                say_color = color.nil? ? COLOR_MAP[:#{method}] : color
                @shell.say(message,say_color,force_new_line)
              end
          CODE
        end
      end
    end
  end
end
