require_relative 'boot'

require 'rails/all'
require 'devise'
require 'turbolinks'
require 'jquery-rails'
require 'jquery-turbolinks'
require 'bootstrap-sass'
require 'httparty'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

module JiraTimeReporting
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # if Rails.env.development?
    #   Spring.watch "#{Rails.root}/app/services/**"
    # end
  end
end
