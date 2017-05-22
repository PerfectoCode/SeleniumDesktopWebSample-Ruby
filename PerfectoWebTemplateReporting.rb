require 'test/unit'
require 'perfecto-reporting'
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
    @reportiumClient = create_reportium_client
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    if self.passed?
      @reportiumClient.testStop(TestResultFactory.createSuccess)
    else
      @reportiumClient.testStop(TestResultFactory.createFailure(@exception.message, @exception))
    end

    @driver.quit

    # Retrieve the URL to the DigitalZoom Report (= Reportium Application) for an aggregated view over the execution
    reportURL = @reportiumClient.getReportUrl

    # Retrieve the URL to the Execution Summary PDF Report
    reportPdfUrl = @driver.capabilities['reportPdfUrl']

    puts 'reportUrl='.concat reportURL

    # For detailed documentation on how to export the Execution Summary PDF Report, the Single Test report and other attachments such as
    # video, images, device logs, vitals and network files - see http://developers.perfectomobile.com/display/PD/Exporting+the+Reports

  end

  # Reporting client. For more details, see http://developers.perfectomobile.com/display/PD/Reporting
  def create_reportium_client
    perfectoExecutionContext = PerfectoExecutionContext.new(
        PerfectoExecutionContext::PerfectoExecutionContextBuilder
            .withProject(Project.new('Reporting SDK Ruby', '1')) # Optional
            .withJob(Job.new('Ruby Job', 1)) # Optional
            .withContextTags('Tag1') # Optional
            .withWebDriver(@driver)
            .build)

    PerfectoReportiumClient.new(perfectoExecutionContext)
  end

  def test_web
    begin
      @reportiumClient.testStart(self.name, TestContext.new('Tag2', 'Tag3'))
      puts 'Run started'

      @reportiumClient.stepStart 'Navigate to google'
      @driver.get 'http://google.com/'
      @reportiumClient.stepEnd

      # complete your test here
    end
  end

end