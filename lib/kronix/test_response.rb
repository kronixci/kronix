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
      return false unless self.run_tests_command

      if before_command = self.before_command
        pid = Process.fork {
          `#{before_command} > /dev/null 2>&1`
        }
        Process.waitpid(pid)
      end

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
      YAML.load(File.read(file))["run"] rescue nil
    end

    # Identify the commands that needs runs before the test suite
    # Ex: database migration, db seed, etc.
    #
    # Returns String
    def self.before_command
      file = File.join(Dir.pwd, 'kronix.yml')
      YAML.load(File.read(file))["before"] rescue nil
    end
  end
end
