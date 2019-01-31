require "app_prism/version"

module AppPrism
  require_relative 'app_prism/sections/section_finders'
  require_relative 'app_prism/sections/screen_section'
  require_relative 'app_prism/sections/sections_collection'
  require_relative 'app_prism/platforms/platform'
  require_relative 'app_prism/platforms/appium_platform'
  require_relative 'app_prism/helper_methods'
  require_relative 'app_prism/screen_factory'

  DEFAULT_WAIT_TIME ||= 5

  def initialize(driver)
    @platform = AppPrism::Platforms::AppiumPlatform.new(driver)
  end

  def self.included(cls)
    cls.include AppPrism::HelperMethods
    cls.include AppPrism::ScreenFactory
    cls.extend AppPrism::Finders
    cls.extend AppPrism::Sections::SectionFinders
  end
end
