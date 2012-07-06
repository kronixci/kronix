require 'yaml'
require 'kronix/rspec_engine'
require 'kronix/test_response'
require 'kronix/extractor'

module Kronix
  def self.build(path)
    old_dir = Dir.pwd
    FileUtils.cd(path)
    result = TestResponse.process
    FileUtils.cd(old_dir)

    result.fails == 0
  end
end
