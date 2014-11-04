require 'rundeck'
require 'rundeck_manager/configuration'
require 'rundeck_manager/client'
require 'rundeck_manager/version'

module RundeckManager
  extend Configuration

  # Alias for Rundeck::Client.new
  #
  # @return [Rundeck::Client]
  def self.client(options = {})
    RundeckManager::Client.new(options)
  end

  # Delegate to Gitlab::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Gitlab::Client
  def self.respond_to?(method)
    client.respond_to?(method) || super
  end
end
