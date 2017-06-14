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
    # Holidays.between(Date.civil(2017,1,1), 5.years.from_now, :ee, :observer).map do |holiday|
    #   BusinessTime::Config.holidays << holiday[:date]
    # end

    # use OmniAuth::Builder do
    #   provider :JIRA, 
    #     "<consumer_key>", 
    #     OpenSSL::PKey::RSA.new(IO.read(File.dirname(__FILE__) + "<PRIVATE_KEY_FILE>")),
    #     :client_options => { :site => "<http://jira.url>" }
    # end
  end
end
