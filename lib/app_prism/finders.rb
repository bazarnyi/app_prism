# require_relative 'elements/elements_collection'
# require_relative 'sections/section_finders'
# require_relative 'sections/screen_section'
# require_relative 'sections/sections_collection'

module AppPrism
  module Finders

    def element(name, identifiers)
      define_method("#{name}_element") do
        get_element_for(identifiers)
      end

      define_method(name) do |&block|
        get_element_for(identifiers).click
      end

      define_method("#{name}?") do
        get_element_for(identifiers).visible?
      end

      define_method("#{name}=") do |value|
        get_element_for(identifiers).send_keys(value)
      end
    end

    def elements(name, identifiers)
      define_method("#{name}_elements") do
        get_elements_for(identifiers)
      end
    end

    def expected_element(name, wait_time = 0, timeout = AppPrism::DEFAULT_WAIT_TIME)
      define_method("has_expected_element?") do
        sleep wait_time
        self.respond_to?("#{name}_element") && self.send("#{name}_element").when_visible(timeout)
      end
    end
  end
end