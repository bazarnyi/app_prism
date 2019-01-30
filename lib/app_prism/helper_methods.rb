# if ENV['PLATFORM'] == 'ios'
#   require 'calabash-cucumber/cucumber'
#   require_relative 'platforms/i_platform'
# elsif ENV['PLATFORM'] == 'android'
#   require 'calabash-android/cucumber'
#   require_relative 'platforms/a_platform'
# end
# require_relative '../app_prism/platforms/rm'
require_relative '../app_prism/elements/element'

module AppPrism
  module HelperMethods
    def android?
      ENV['ANDROID'] == 'true'
    end

    def ios?
      ENV['IOS'] == 'true'
    end

    def platform
      @platform ||= AppPrism::Platforms::AppiumPlatform.new(@driver)
    end

    def get_element_for(identifiers)
      AppPrism::Elements::Element.new(identifiers, platform)
    end

    def get_elements_for(identifiers)
      AppPrism::Elements::ElementsCollection.new(identifiers, platform)
    end

    def default_wait_time
      AppPrism::DEFAULT_WAIT_TIME || 30
    end

    def wait_for(wait_time = default_wait_time)
      start_time = Time.now
      loop do
        return true if yield
        break unless (Time.now - start_time) < wait_time
        sleep 0.5
      end
      raise Timeout::Error, 'Timed out while waiting for block to return true'
    end
  end
end