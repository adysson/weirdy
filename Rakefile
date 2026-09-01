require "bundler/setup"

begin
  require "bundler/gem_helper"
rescue LoadError
  puts "You must run `bundle install` to run rake tasks"
  exit
end

Bundler::GemHelper.install_tasks

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
