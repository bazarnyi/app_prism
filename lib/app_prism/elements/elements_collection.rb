module AppPrism
  module Elements
    class ElementsCollection
      include Enumerable

      def initialize(identifiers, element_or_driver)
        if identifiers.keys.include?(:android) || identifiers.keys.include?(:ios)
          @locator = identifiers[:android] if android?
          @locator = identifiers[:ios] if ios?
        else
          @locator = identifiers
        end

        @element_or_driver = element_or_driver
        @sel_elements  = @element_or_driver.find_elements(@locator) #maybe allow it to be empty if elements are not visible yet
        @elements = @sel_elements.map do |elt|
          AppPrism::Elements::Element.new(elt, @element_or_driver)
        end
      end

      def each(&block)
        @elements.each(&block)
      end

      def [](index)
        @elements[index]
      end
    end
  end
end