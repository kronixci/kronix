require 'rake'
require 'rake/testtask'

task :default => [:test]

desc "Run Kronix tests"
Rake::TestTask.new("test") do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end
