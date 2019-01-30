module AppPrism
  module ScreenFactory
    def on_page(page_class, *args)
      page_class = class_from_string(page_class) if page_class.is_a? String
      @current_screen = page_class.new(@browser)
    end

    alias_method :on, :on_page

    def class_from_string(class_name)
      parts = class_name.split("::")
      constant = Object
      parts.each do |part|
        constant = constant.const_get(part)
      end
      constant
    end
  end
end