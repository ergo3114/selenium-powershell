Import-Module $PSScriptRoot\..\Selenium -Force

Describe "Selenium Tests" {
    BeforeAll {
        $ffdriver = Start-SeFirefox
        $chromedriver = Start-SeChrome -Arguments "headless"
    }

    AfterAll {
        Stop-SeDriver -Driver $ffdriver
        Stop-SeDriver -Driver $chromedriver
    }

    Context "Get-SeCookie" {
        It "Should get cookies from <URL> in FireFox" -TestCases @(
            @{URL = "https://www.nasa.gov/"}
            #@{URL = "https://github.com/"}
            @{URL = "https://www.netflix.com/"}
        ) {
            param($URL)

            Enter-SeUrl -Driver $ffdriver -Url $URL
            Get-SeCookie $ffdriver
        }

        It "Should get cookies from <URL> in Chrome" -TestCases @(
            @{URL = "https://www.nasa.gov/"}
            @{URL = "https://github.com/"}
            @{URL = "https://www.netflix.com/"}
        ) {
            param($URL)

            Enter-SeUrl -Driver $chromedriver -Url $URL
            Get-SeCookie $chromedriver
        }
    }
}