require_relative '../../app_prism/elements/element'
require_relative '../finders'

module AppPrism
  module Sections
    class ScreenSection < Elements::Element
      extend AppPrism::Finders
      extend AppPrism::Sections::SectionFinders

      def get_element_for(identifiers)
        nested_element(identifiers)
      end

      def get_elements_for(identifiers)
        nested_elements(identifiers)
      end
    end
  end
end
