module Kronix
  class RspecEngine
    # Responsability:
    #   Identify fails, passes and pending tests in rspec response
    #
    # end_line - String with last line of rspec command
    #
    # Returns Array with ok, fails, and pending tests
    def self.parse(end_line)
      pattern = /(\d+) examples?, (\d+) failures?(, (\d+) pending)?/
      _, test, fails, _, wait = *end_line.match(pattern)
      [test, fails, wait].map.collect(&:to_i)
    end
  end
end
