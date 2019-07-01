# AppPrsim

[![CircleCI](https://circleci.com/gh/bazarnyi/app_prism.svg?style=svg&circle-token=0a76b7197e2a4894e8958548cb5203077a117e38)](https://circleci.com/gh/bazarnyi/app_prism)

_A Multi-platform Page Object Model DSL for Appium_

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_prism'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install app_prism

## Usage

Here's an overview of how SitePrism is designed to be used:

```ruby
# define your app screens

class BaseScreen
  include AppPrism

  element :app_icon,      android: { id: 'ViewActivityIntro_AppLogo' },
                          ios: { xpath: '//XCUIElementTypeIcon[@name="some name here"]' }

  element :notification,  android: { accessibility_id: 'NotificationShortLookView' },
                          ios: { accessibility_id: 'NotificationShortLookView' }

  element :toolbar_done,  android: { xpath: '//android.widget.LinearLayout[@content-desc="ViewActivityIntro_Toolbar"]/android.widget.TextView' },
                          ios: { xpath: '//XCUIElementTypeToolbar[@name="Toolbar"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[@name="DONE" or @name="Done"]' }

  def wheelpicker
    @driver.find_elements(:class_name, 'XCUIElementTypePickerWheel').first
  end
end

class LogInScreen < BaseScreen
  element :log_in_button, android: { id: 'ButtonRoundCorner_CustomImageView_Icon' },
                                ios: { accessibility_id: 'LOG IN' }
end

# define sections used on multiple screens or multiple times on one screen

class ScreenDialog < AppPrism::Sections::ScreenSection
  element :title, android: { id: 'title' },
                  ios: { xpath: '//XCUIElementTypeStaticText[@name="Skip account"]' }

  element :yes,   android: { id: 'FragmentTwoButtonAlertDialog_Button_Positive' },
                  ios: { accessibility_id: 'Yes' }

  element :no,    android: { id: 'FragmentTwoButtonAlertDialog_Button_Negative' },
                  ios: { accessibility_id: 'No' }
end

# Basic usage in tests are very similar to usage of Site Prism gem for Web UI test automation
# the only difference is that page factory approach is used to better manage screens interractions

Given(/^I launch the app$/) do
  if ios?
    accept_ios_notification
  else
    wait_while_app_is_loading
  end
end

Given(/^I swipe demo screens to the Sign in form$/) do
  wait_for_activity_to_load 'IntroductionActivity' if android?
  wait_for_element 'view pager', 'welcome'
  6.times do
    swipe 'left'
  end
end

Then(/^I see relevant skip sign in notification dialog$/) do
  expect(on(WelcomeScreen).screen_dialog.title_element.text).to include 'some text'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/app_prism. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AppPrism project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/app_prism/blob/master/CODE_OF_CONDUCT.md).
