require 'spec_helper'

describe RundeckManager do
  after { RundeckManager.reset }

  # nothing too special to check, just existence
  it { is_expected.to respond_to(:yaml_path) }
  it { is_expected.to respond_to(:yaml_path=) }

  # Rundeck gem configuration options
  it { is_expected.to respond_to(:endpoint) }
  it { is_expected.to respond_to(:endpoint=) }
  it { is_expected.to respond_to(:api_token) }
  it { is_expected.to respond_to(:api_token=) }

  describe '.configure' do
    RundeckManager::Configuration::VALID_OPTIONS_KEYS.each do |key|
      context "when setting #{key}" do
        subject { RundeckManager.send(key) }

        before do
          RundeckManager.configure do |config|
            config.send("#{key}=", key)
          end
        end

        it { is_expected.to eq(key) }
      end
    end

    RundeckManager::Configuration::VALID_RD_OPTIONS_KEYS.each do |key|
      context "when setting rundeck #{key}" do
        subject { Rundeck.send(key) }

        before do
          RundeckManager.configure do |config|
            config.send("#{key}=", key)
          end
        end
        if key == :endpoint
          it { is_expected.to include(key.to_s) }
        else
          it { is_expected.to eq(key) }
        end
      end
    end
  end
end
