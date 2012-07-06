require 'yaml'
require 'kronix/project'
require 'kronix/rspec_engine'
require 'kronix/test_response'
require 'kronix/extractor'

module Kronix
  def self.install(project, path)
    Project.clone(project, path)
  end

  def self.build(path)
    old_dir = Dir.pwd
    FileUtils.cd(path)
    result = TestResponse.process
    FileUtils.cd(old_dir)

    result.fails == 0
  end
end
