# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'specmon/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'specmon'
  s.version     = Specmon::VERSION
  s.authors     = ['Quentin Rousseau']
  s.email       = ['quentin@instacart.com']
  s.homepage    = 'https://github.com/instacart/specmon'
  s.summary     = 'Monitor your specs'
  s.description = 'Monitor your specs runtime and owners'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rails', '~> 4.2.6', '>= 4.2.6'
  s.add_runtime_dependency 'pg', '~> 0.18.4', '>= 0.18.4'
  s.add_runtime_dependency 'jquery-rails', '~> 4.1.1', '>= 4.1.1'
  s.add_runtime_dependency 'haml-rails', '~> 0.9.0', '>= 0.9.0'
  s.add_runtime_dependency 'bootstrap-sass', '~> 3.3.6', '>= 3.3.6'
  s.add_runtime_dependency 'sass-rails', '~> 5.0.4', '>= 5.0.4'
  s.add_runtime_dependency 'kaminari', '~> 0.16.3', '>= 0.16.3'
  s.add_runtime_dependency 'bootstrap-kaminari-views', '~> 0.0.5', '>= 0.0.5'
  s.add_runtime_dependency 'uglifier', '~> 3.0.0', '>= 3.0.0'
  s.add_runtime_dependency 'activerecord-import', '~> 0.13.0', '>= 0.13.0'
  s.add_runtime_dependency 'chartkick', '~> 1.4.2', '>= 1.4.2'
  s.add_runtime_dependency 'descriptive_statistics', '~> 2.5.1', '>= 2.5.1'
  s.add_runtime_dependency 'faraday', '~> 0.9.2', '>= 0.9.2'
end
