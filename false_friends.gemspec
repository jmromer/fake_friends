# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'false_friends/version'

Gem::Specification.new do |spec|
  spec.name          = "FalseFriends"
  spec.version       = FalseFriends::VERSION
  spec.authors       = ["Jake Romer"]
  spec.email         = ["jake@jakeromer.com"]
  spec.description   = %q{A simple fake user generator}
  spec.summary       = %q{Generates fake users with consistent
                        attributes, up to 30 from local dictionary,
                        up to 200 pulling fresh data using the Twitter gem}
  spec.homepage      = "http://jmromer.github.com/FalseFriends"
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "psych"
  spec.add_runtime_dependency "twitter"

  spec.add_development_dependency "psych"
  spec.add_development_dependency "twitter"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
