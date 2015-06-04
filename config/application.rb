require File.expand_path('../boot', __FILE__)

# require 'rails/all'

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppleScraping
  class Application < Rails::Application
    # start parsing with this url
    config.url = 'https://selfsolve.apple.com/agreementWarrantyDynamic.do'
  end
end
