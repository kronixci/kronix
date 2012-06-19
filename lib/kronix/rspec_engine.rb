module Kronix
  class RspecEngine
    def self.parse(end_line)
      pattern = /(\d+) examples?, (\d+) failures?(, (\d+) pending)?/
      regex, test, fails, waiting, wait = *end_line.match(pattern)
      [test, fails, wait].map.collect(&:to_i)
    end
  end
end
