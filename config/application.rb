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
    BusinessTime::Config.work_week = [:mon, :tue, :wed, :fri]
    BusinessTime::Config.beginning_of_workday = "7:00 am"
    BusinessTime::Config.end_of_workday = "7:30 pm"
    # Holidays.load_custom("#{Rails.root}/config/ee_custom_holidays.yaml")
    # Holidays.between(Date.civil(2017,1,1), 5.years.from_now, :ee, :observer).map do |holiday|
    #   BusinessTime::Config.holidays << holiday[:date]
    # end
  end
end
