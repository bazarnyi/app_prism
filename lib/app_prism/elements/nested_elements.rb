require_relative 'elements_collection'

module AppPrism
  module Elements
    module NestedElements

      def nested_elements(identifiers)
        ElementsCollection.new(identifiers, element)
      end
    end
  end
end