module AppPrism
  module Platforms
    class Platform
      def initialize(driver = nil)
        @driver = driver if driver
      end

      attr_reader :driver
    end
  end
end