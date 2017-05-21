# Ruby Web Automation Code Sample

[![CircleCI](https://circleci.com/gh/PerfectoCode/WebAutomationSampleRuby.svg?style=shield&circle-token=82109730b34b944f677b7dc61d1030cf4c429d44)](https://circleci.com/gh/PerfectoCode/WebAutomationSampleRuby)

This code sample demonstrates how to use Perfecto Web Machines & Selenium + Ruby programing language in order to execute tests 
for your web applications on the cloud. 

### Getting Stated: 
- Clone or download the sample:<br/> `git clone https://github.com/PerfectoCode/WebAutomationSampleRuby.git`
- Add your Perfecto Lab credentials within the [WebAppE2E.rb](PerfectoWebTemplate.rb) file:
```Ruby
...
@@User = ENV['user']
@@Pass = ENV['password']
@@Host = ENV['host']
@@token = ENV['token']
... 
```
Note! you may want to use env variable for your credentials as demonstrated

- Note:exclamation: the project include 4 templates: 
    - PerfectoFastWebTemplate: template for Perfecto Turbo Web.
    - PerfectoFastWebTemplateReporting: template for Perfecto Turbo Web + DigitalZoom Reporting.
    - PerfectoWebTemplate: basic web automation template.
    - PerfectoWebTemplateReporting: same as the basic template + DigitalZoom Reporting.
    
- Run the project from your IDE or using command line for example `ruby PerfectoFastWebTemplate.rb`

### Web Capabilities: 

- To insure your tests run on Perfecto Web machines on the cloud use the capabilities as demonstrated in the code sample: <br/>
```Ruby
@BeforeMethod
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
```

- More capabilities are available, read more [here](http://developers.perfectomobile.com/display/PD/Supported+Platforms).

### Perfecto Turbo Web Automation:

Perfecto's Desktop Web environment introduces an accelerated interface to Web Browser automation with its new Turbo web interface. Using this new environment will allow you to connect quicker to the browser "device" you select for automating and testing your web application.

*Click [here](http://developers.perfectomobile.com/display/PD/Turbo+Web+Automation) to read more about Turbo Web Automation.*

- To enable Turbo Web Automation in this code sample follow the instructions in the link above in order to generate authentication token.
Place the authentication in one of the Turbo Web test's files:
```Ruby
@@Host = ENV['host']
@@token = ENV['token']

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
    securityToken: @@token,
}
...
```

### Perfecto DigitalZoom reporting:

Perfecto Reporting is a multiple execution digital report, that enables quick navigation within your latest build execution. Get visibility of your test execution status and quickly identify potential problems with an aggregated report.
Hone-in and quickly explore your test results all within customized views, that include logical steps and synced artifacts. Distinguish between test methods within a long execution. Add personalized logical steps and tags according to your team and organization.

*Click [here](http://developers.perfectomobile.com/display/PD/Reporting) to read more about DigitalZoom Reporting.*
