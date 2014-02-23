require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yaml'

RSpec::Core::RakeTask.new('spec')
task default: :spec


task :refresh_library do
  credentials = YAML.load_file('application.yml')
  credentials.each_pair{ |key, val| ENV[key] = val }
  ruby "dev/fetch_from_twitter.rb"
end



