require_relative '../../app_prism/elements/elements_collection'
require_relative 'sections_collection'

module AppPrism
  module Sections
    module SectionFinders

      def screen_section(name, section_class, identifiers)
        define_method(name) do
          if android?
            new_identifiers = identifiers[:android].clone
          elsif ios?
            new_identifiers = identifiers[:ios].clone
          else
            raise '[31m' + 'OS is not specified. Please run tests with ANDROID=true or IOS=true' + '[0m'
          end
          section_class.new(new_identifiers, @platform.driver)
        end

        define_method("#{name}_element") do
          get_element_for(identifiers)
        end

        define_method("#{name}?") do
          get_element_for(identifiers).visible?
        end

      end

      def screen_sections(name, section_class, identifiers)
        define_method(name) do
          sections_ary = AppPrism::Elements::ElementsCollection.new(identifiers, platform).map do |elt|
            section_class.new(elt.element, platform)
          end
          AppPrism::Sections::SectionsCollection[*sections_ary]
        end
      end
    end
  end
end