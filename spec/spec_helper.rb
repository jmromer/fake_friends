require 'fake_friends'
require 'rspec/expectations'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Matchers.define :be_composed_of do |expected_type|
  match do |actual|
    actual.all? { |u| u.is_a? expected_type }
  end

  failure_message do |actual|
    "expected #{actual.class} to be composed of #{expected_type}s"
  end
end
