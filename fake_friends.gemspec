# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_friends/version'

Gem::Specification.new do |spec|
  spec.name          = 'fake_friends'
  spec.version       = FakeFriends::VERSION
  spec.authors       = ['Jake Romer']
  spec.email         = ['jacob.romer@icloud.com']
  spec.description   = 'A simple fake user generator'
  spec.summary       = 'Generates fake users with consistent attributes from public Twitter accounts and image urls from uiFaces.com.'
  spec.homepage      = 'http://github.com/jkrmr/fake_friends'
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'twitter', '~> 5.6'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.1'
end
