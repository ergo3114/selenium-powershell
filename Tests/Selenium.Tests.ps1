Import-Module $PSScriptRoot\..\Selenium -Force

Describe "Get-SeCookie" {
    BeforeAll {
        $ffdriver = Start-SeFirefox
        $chromedriver = Start-SeChrome -Arguments "headless"
    }

    AfterAll {
        Stop-SeDriver -Driver $ffdriver
        Stop-SeDriver -Driver $chromedriver
    }

    Context "FireFox" {
        It "Should get cookies from <URL>" -TestCases @(
            @{URL = "https://www.nasa.gov/"}
            #@{URL = "https://github.com/"}
            @{URL = "https://www.netflix.com/"}
        ) {
            param($URL)

            Enter-SeUrl -Driver $ffdriver -Url $URL
            Get-SeCookie $ffdriver
        }
    }

    Context "Chrome" {
        It "Should get cookies from <URL>" -TestCases @(
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