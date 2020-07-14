# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Run all the tests'
task default: :test

Rake::TestTask.new("test:regular") do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
  t.verbose = true
end

desc "Run all the fast + platform agnostic tests"
task test: %w[test:regular]

desc "Run all the tests we run on CI"
task ci: :test
