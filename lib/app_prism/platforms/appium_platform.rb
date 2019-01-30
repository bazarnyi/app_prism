require_relative 'platform'

module AppPrism
  module Platforms
    class AppiumPlatform < Platform

      def find_element(identifiers)
        @driver.find_element(identifiers)
      rescue Selenium::WebDriver::Error::NoSuchElementError
        raise "Cannot find such element: #{identifiers}"
      end

      def refresh
        start_x = screen_width/2
        start_y = screen_height/2
        end_y = start_y * 1.7

        end_x = start_x
        @driver.swipe(start_x: start_x,
                      start_y: start_y,
                      end_x: end_x,
                      end_y: end_y,
                      duration: 1000)
      end

      def find_elements(identifiers)
        @driver.find_elements(identifiers)
      end

      def screen_width
        @driver.window_size.width
      end

      def screen_height
        @driver.window_size.height
      end

      def swipe_up(element)
        start_x = element.location.x + element.size.width/2
        start_y = element.location.y + element.size.height * 0.95
        end_y = element.location.y * 1.05

        end_x = start_x
        @driver.swipe(start_x: start_x,
                      start_y: start_y,
                      end_x: end_x,
                      end_y: end_y,
                      duration: 3000)
      end

      def swipe_down(element)
        location = element.location
        start_x = location.x + element.size.width/2
        start_y = location.y + element.size.height * 0.05
        end_y = location.y + element.size.height * 0.95

        end_x = start_x
        @driver.swipe(start_x: start_x,
                      start_y: start_y,
                      end_x: end_x,
                      end_y: end_y,
                      duration: 3000)
      end

      def hide_keyboard
        tries ||= 3
        sleep 1
        @driver.hide_keyboard
      rescue Selenium::WebDriver::Error::UnknownError
        retry unless (tries -= 1).zero?
      end

      def set_native_context
        @driver.set_context('NATIVE_APP')
      end

      def set_web_context
        @driver.set_context("WEBVIEW_#{app_package}")
      end

      def native_context?
        @driver.current_context == 'NATIVE_APP'
      end

      def app_package
        @driver.caps[:appPackage]
      end

    end
  end
end