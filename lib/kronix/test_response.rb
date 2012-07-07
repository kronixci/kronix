module Kronix
  class TestResponse
    attr_reader :pass

    def initialize(pass)
      @pass = pass
    end

    # Verifiy if tests are ok
    #
    # Returns boolean
    def pass?
      @pass
    end

    # Run a the test command framework
    # and check if it pass. If tests
    # are ok then exit code will be 0 else other number
    #
    # Returns boolean
    def self.run
      `#{self.run_tests_command} > /dev/null 2>&1` 
      $?.exitstatus.zero?
    end

    # Process the test framework response to app
    #
    # Returns Kronix::TestResponse
    def self.process
      new (self.run)
    end

    # Identify what command run the test framework
    #
    # Returns String
    def self.run_tests_command
      file = File.join(Dir.pwd, 'kronix.yml')
      YAML.load(File.read(file))["run"]
    end
  end
end
