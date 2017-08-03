require 'selenium/webdriver'
require 'capybara'
require 'test/unit'
require 'test/unit/assertions'
require 'rspec'
require 'capybara-screenshot/cucumber'
require 'capybara/cucumber'
require 'site_prism'
include Test::Unit::Assertions

# Config
$config = YAML::load_file(File.join('config.yml'))

$cash_url = ENV['CASH_URL']

puts "Selecting Cash application environment: #{ENV['CASH_URL']}"

# Disable Proxy. Every now and then proxy occurs disability to connect to Selenium Hub.
# Till the solution not found this string must be executed
ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil

# Screenshots path
Capybara.save_path = "screenshots/"
Dir.mkdir(Capybara.save_path) unless File.exists?(Capybara.save_path)

# Set auto screenshots on test failure
Capybara::Screenshot.autosave_on_failure = true

if ENV['REMOTE_HUB'] != nil then
  Capybara.default_driver = :remote_browser
  Capybara.javascript_driver = :remote_browser
  hub_url = ENV['REMOTE_HUB']
else
  Capybara.default_driver = :chrome
  Capybara.javascript_driver = :chrome
end

puts "Selecting Selenium-hub: #{ENV['REMOTE_HUB']}"

# Selenium Hub
# capabilities
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['browserName'] = 'chrome'
  capabilities['version'] = ''
  capabilities['platform'] = 'ANY'
# capabilities['video'] = 'True'

Capybara.register_driver :remote_browser do |app|

  # If the requested test environment is not registered with the selenium grid hub
  # or busy, allow enough time for the Gridlastic auto scaling
  # functionality to launch a node with the requested environment.
  #
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 12000 #seconds

  Capybara::Selenium::Driver.new(
      app, http_client: client,
      :browser => :remote,
      :url => hub_url,
      :desired_capabilities => capabilities)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
      app,
      :browser => :chrome,
      :desired_capabilities => capabilities)
end

# Set :remote_browser save_screenshot method to enable rendering
Capybara::Screenshot.register_driver(:remote_browser) do |driver, path|
  driver.save_screenshot path
end

#Capybara settings
Capybara.default_max_wait_time = $config['capybara']['default_max_wait_time']
Capybara.current_session.driver.browser.manage.window.maximize

Capybara.run_server = false

# Disable SSL verification to allow pdf-reader get statement by URL
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

