module RundeckManager
  class Client
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Jobs

    # @private
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    # @private
    attr_accessor(*Configuration::VALID_RD_OPTIONS_KEYS)

    def initialize(options = {})
      options = RundeckManager.options.merge(options)
      opt_keys = Configuration::VALID_OPTIONS_KEYS.concat(
          Configuration::VALID_RD_OPTIONS_KEYS)

      opt_keys.each do |key|
        send("#{key}=", options[key]) if options.key?(key)
      end
    end
  end
end
