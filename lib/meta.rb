require 'mono_logger'
require 'nokogiri'
require 'selenium-webdriver'

require 'meta/version'
require 'meta/scalper'
require 'meta/catalog'
require 'meta/thread'

module Meta
  extend self
  # Set and get for the logger
  attr_accessor :logger

  # The driver is the handle that will load
  # the page using a real browser.
  def driver
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['plugin.default.state'] = '0'

    capabilities = Selenium::WebDriver::Remote::Capabilities.firefox firefox_profile: profile

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120

    driver = Selenium::WebDriver.for :remote, http_client: client, desired_capabilities: capabilities
    driver.manage.timeouts.implicit_wait = 120

    # driver = Selenium::WebDriver.for(:remote, desired_capabilities: :firefox)
    # driver.manage.timeouts.implicit_wait = 5
    driver
  end
end

Meta.logger = MonoLogger.new(STDOUT)
