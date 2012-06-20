require 'yaml'
require 'kronix/project'
require 'kronix/rspec_engine'
require 'kronix/test_response'
require 'kronix/extractor'

module Kronix
  def self.ci(project, path)
    old_dir = Dir.pwd

    to = File.join(path, Project.clone(project, path))
    FileUtils.cd(to)
    result = TestResponse.process

    FileUtils.cd(old_dir)
    if result.fails > 0
      false
    else
      true
    end
  end
end
