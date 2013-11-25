# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'FalseFriends/version'

Gem::Specification.new do |spec|
  spec.name          = "FalseFriends"
  spec.version       = FalseFriends::VERSION
  spec.authors       = ["Jake Romer"]
  spec.email         = ["jake@jakeromer.com"]
  spec.description   = %q{A fake user generator}
  spec.summary       = %q{Generates fake users with consistent
                        attributes (avatar image, posts, etc).}
  spec.homepage      = "http://jmromer.github.com/FalseFriends"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
