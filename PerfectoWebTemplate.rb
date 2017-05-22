require 'test/unit'
require 'selenium-webdriver'

# Perfecto Desktop Web Using Selenium WebDriver:
# This project demonstrate simply how to open a Desktop Web
# machine within your Perfecto Lab in the cloud and running your tests
class MyTest < Test::Unit::TestCase

  @@User = ENV['user']
  @@Pass = ENV['password']
  @@Host = ENV['host']

  attr_accessor :driver, :reportiumClient, :exception

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    capabilities = {
        platformName: 'Windows',
        platformVersion: '10',
        browserName: 'Chrome',
        browserVersion: '58',
        resolution: '1280x1024',
        user: @@User,
        password: @@Pass
    }
    _url = 'http://' + @@Host + '/nexperience/perfectomobile/wd/hub'

    @driver = Selenium::WebDriver.for(:remote, :url => _url, :desired_capabilities => capabilities)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    @driver.close
    @driver.quit
  end

  def test_web
    begin
      puts 'Run started'
      @driver.get 'http://google.com/'

      # complete your test here
    end
  end

end