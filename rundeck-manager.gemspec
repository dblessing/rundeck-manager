# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rundeck-manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'rundeck-manager'
  spec.version       = RundeckManager::VERSION
  spec.authors       = ['Drew A. Blessing']
  spec.email         = ['drew.blessing@mac.com']
  spec.description   = 'Project and job manager for Rundeck'
  spec.summary       = 'Manage Rundeck projects and jobs from YAML files'
  spec.homepage      = 'http://dblessing.github.io/rundeck-manager'
  spec.license       = 'BSD-2-Clause'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'rundeck'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'rspec-core', '~> 3.1.2'
  spec.add_development_dependency 'rspec-its', '~> 1.0.0'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'guard-rspec', '~> 4.3.0'
  spec.add_development_dependency 'guard-rubocop'
end
