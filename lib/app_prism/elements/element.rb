module AppPrism
  module Elements
    class Element

      attr_reader :locator, :platform

      def initialize(identifiers, driver)
        if identifiers.is_a?(Selenium::WebDriver::Element)
          @element = identifiers
        else
          if identifiers.keys.include?(:android) || identifiers.keys.include?(:ios)
            @locator = identifiers[:android] if android?
            @locator = identifiers[:ios] if ios?
          else
            @locator = identifiers
          end
        end
        @platform = driver
      end

      def element
        @element || @platform.find_element(@locator)
      rescue RuntimeError
        nil
      end

      # def scroll(direction)
      #   @platform.scroll(@locator, direction)
      # end

      # def fast_scroll(direction)
      #   @platform.fast_scroll(@locator, direction)
      # end

      # def scroll_list_down
      #   @platform.scroll_list_down @locator
      # end

      # def swipe direction
      #   @platform.send("swipe_#{direction}", @locator)
      # end

      # def drag_and_drop(direction)
      #   @platform.send("drag_and_drop_#{direction}", @locator, parent_locator)
      # end

      # def drag_and_drop_to(element_to)
      #   @platform.drag_and_drop_to(@locator, element_to.locator)
      # end

      # def swipe_left
      #   @platform.swipe_left(@locator)
      # end

      # def left_to_edge
      #   @platform.left_to_edge(@locator)
      # end

      # def swipe_right
      #   @platform.swipe_right(@locator)
      # end

      # def swipe_down
      #   @platform.swipe_down(@locator)
      # end

      # def swipe_up
      #   @platform.swipe_up(@locator)
      # end

      def nested_element(identifiers)
        nested_elt = element.find_element(identifiers[:android]) if android?
        nested_elt = element.find_element(identifiers[:ios]) if ios?
        self.class.new(nested_elt, @platform)
      end

      def when_visible(wait_time = default_wait_time)
        wait_for(wait_time: wait_time) { visible? }
        self
      rescue Timeout::Error
        false
      end

      def when_not_visible(wait_time = default_wait_time)
        wait_for(wait_time: wait_time) { !visible? }
      rescue Selenium::WebDriver::Error::NoSuchElementError,Timeout::Error,RuntimeError
        return
      end

      def default_wait_time
        AppPrism::DEFAULT_WAIT_TIME || 30
      end

      def wait_for(wait_time: default_wait_time)
        start_time = Time.now
        loop do
          return true if yield
          break unless (Time.now - start_time) < wait_time
          sleep 0.5
        end
        raise Timeout::Error, "Timed out while waiting for locator:\"#{@locator}\""
      end

      def send_keys(text)
        element.send_keys text
      end

      def clear
        element.send_keys ''
      end

      def touch
        when_visible.click
      end

      def click
        element.click
      end

      # def long_press
      #   when_visible
      #   @platform.long_touch(@locator)
      # end

      def text
        element.text
      end

      # def value
      #   get_parameter 'value'
      # end

      def parent
        loc = if @locator.has_key? :xpath
                @locator[:xpath] + '/..'
              elsif @locator.has_key? :id
                "//*[@id=\"#{@locator[:id]}\"]/.."
              else
                raise 'Something wrong happened'
              end
        @platform.find_element(loc)
      end

      def visible?
        element.nil? ? false : element.displayed?
        # element ? element.displayed? : false
      end

      # def active?
      #   get_parameter 'enabled'
      # end

      # def scroll_into_view
      #   raise 'Does not work yet'
      # end

      def size
        element.size
        # rect = get_element['rect']
        # height = rect['height']
        # width = rect['width']
        # {height: height, width: width}
      end

      # def empty?
      #   get_element.nil?
      # end

      #android only
      # def selected?
      #   @platform.query(@locator, :selected).first
      # end

      #android only
      # def checked?
      #   @platform.query(@locator, :checked).first
      # end

      # def count
      #   @platform.query(@locator).count
      # end

      # def get_parameter(param)
      #   get_element[param]
      # end

      require_relative 'nested_elements'
      include NestedElements

      # private
      # def get_element
      #   @platform.query(@locator).first
      # end
      #
      # def parent_locator
      #   @locator + ' parent * index:0'
      # end
    end

  end
end