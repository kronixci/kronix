module Kronix
  module Extractor
    class Request
      # Responsability:
      #  Tell where pull was committed
      #
      # - str String with branch ref name
      #    Ex: "refs/heads/master"
      #
      # Returns a string with branch name
      def self.branch(str)
        str.split("/").last
      end
    end
  end
end
