require 'rspec'
require 'rspec/its'
require 'codeclimate-test-reporter'

# Must be called before code is included/required!
CodeClimate::TestReporter.start

require File.expand_path('../../lib/rundeck_manager', __FILE__)

RSpec.configure do |config|
  config.before(:each) do

  end
end
