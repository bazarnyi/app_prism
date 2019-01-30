require "app_prism/version"

module AppPrism
  # require_relative 'app_prism/er_methods'
  # require_relative 'app_prism/ers'
  require_relative 'app_prism/sections/section_finders'
  require_relative 'app_prism/sections/screen_section'
  require_relative 'app_prism/sections/sections_collection'
  # require_relative 'app_prism/en_factory'

  DEFAULT_WAIT_TIME ||= 5

  def initialize(driver)
    @platform = AppPrism::Platforms::AppiumPlatform.new(driver)
  end

  def self.included(cls)
    cls.include AppPrism::HelperMethods
    cls.extend AppPrism::Finders
    cls.extend AppPrism::Sections::SectionFinders
  end
end
