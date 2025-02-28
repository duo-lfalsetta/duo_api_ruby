# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

task default: %i[test rubocop]

desc 'Run tests'
task :test do
  Rake::TestTask.new{ |t| t.libs << 'test' }
end

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end
