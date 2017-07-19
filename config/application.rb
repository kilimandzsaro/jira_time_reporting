require_relative 'boot'

require 'rails/all'
require 'devise'
require 'turbolinks'
require 'jquery-rails'
require 'jquery-turbolinks'
require 'bootstrap-sass'
require 'httparty'
require 'business_time'
require 'holidays'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

module JiraTimeReporting
  class Application < Rails::Application
    config.active_record.time_zone_aware_types = [:datetime, :time]
  end
end
