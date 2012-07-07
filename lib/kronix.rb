require 'yaml'
require 'kronix/test_response'

module Kronix
  def self.build(path)
    old_dir = Dir.pwd
    FileUtils.cd(path)
    result = TestResponse.process

    result.pass?
  ensure
    FileUtils.cd(old_dir)
  end
end
