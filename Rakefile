# require "bundler/gem_tasks"
# task :default => :spec
require 'rake/testtask'
# require "./lib/rcopyfind"

task default: "test"

# task :console do
#   require 'irb'
#   require 'irb/completion'
#   load "rcopyfind.gemspec"
#   ARGV.clear
#   IRB.start
# end

Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
end
