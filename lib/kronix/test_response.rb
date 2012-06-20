module Kronix
  class TestResponse
    attr_reader :tests, :fails, :wait

    def initialize(options)
      @tests, @fails, @wait = *options
    end

    # Responsability:
    #  Parse a string with tests response and retrieve
    #  what fails and examples are ok.
    #
    # - end_line The string with result of assertions
    #    In Rspec: 4 examples, 0 failures, 4 pending
    #
    # Returns Kronix::TestResponse
    def self.parse(end_line)
      new RspecEngine.parse(end_line)
    end

    # Responsability:
    #   Run a the test command framework
    #   and save it in a log file
    #
    # Returns nothing
    def self.run
      `#{self.run_tests_command} > ./test_log`
    end

    # Responsability:
    #   Read the last line of a file, this should be the test
    #   framework response:
    #
    #   Example Rspec:
    #     4 examples, 0 failures, 4 pending
    #
    # Returns a String
    def self.read
      File.read("test_log")
    end

    # Responsability:
    #   Process the test framework response to app
    #
    # Returns Kronix::TestResponse
    def self.process
      self.run
      self.parse(self.read)
    end

    # Responsability
    #   Identify what command represents the test framework
    #
    # Returns String
    def self.run_tests_command
      file = File.join(Dir.pwd, 'kronix.yml')
      YAML.load(File.read(file))["run"]
    end
  end
end
