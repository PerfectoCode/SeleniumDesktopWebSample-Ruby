require 'test/unit'
require 'perfecto-reporting'
require 'selenium-webdriver'

# Perfecto Web Automation Code Sample
class MyTest < Test::Unit::TestCase

  @@User = ENV['user']
  @@Pass = ENV['password']
  @@Host = ENV['host']
  @@token = 'MyAuthToken'

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

    # For Perfecto Turbo Web solution follow the instructions at http://developers.perfectomobile.com/display/PD/Turbo+Web+Automation
    # Enable the following lines of code to enable Turbo Web:
    # _url += '/fast'
    # capabilities['securityToken'] = @@token

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

      # complete your test here instead of the sample scenario

      ## Sample Scenario ##
      @reportiumClient.stepStart 'Step 1: Navigate to developers.perfectomobile.com'
      @driver.get 'http://developers.perfectomobile.com/'
      @reportiumClient.stepEnd

      @reportiumClient.stepStart 'Step 2: Search for \"Turbo Web\" documentation'
      search_val = 'Turbo Web'
      @driver.find_element(:id => 'quick-search-query').send_keys(search_val)
      @reportiumClient.stepEnd

      @reportiumClient.stepStart 'Step 3: Click the Turbo Web Automation search result'
      @driver.find_element(:xpath => '//*[contains(text(), "Turbo Web Automation")]').click
      @reportiumClient.stepEnd

      @reportiumClient.stepStart 'Step 3: Assert page contain text'
      text = 'Platforms Supported by Turbo Web'
      elem = @driver.find_elements(:xpath => "//*[contains(text(), 'Platforms Supported by Turbo Web')]")
      @reportiumClient.reportiumAssert("Text %s is presented?" % text, (not elem.empty?))
      @reportiumClient.stepEnd
    end
  end

end