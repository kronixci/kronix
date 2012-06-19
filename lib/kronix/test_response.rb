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

    def self.run
      `#{self.run_tests_command} > ./test_log`
    end

    def self.read
      File.read("test_log").split("\n").last
    end

    def self.process
      self.run
      self.parse(self.read)
    end

    def self.run_tests_command
      file = File.join(Dir.pwd, 'config.yml')
      YAML.load(File.read(file))["run"]
    end
  end
end
