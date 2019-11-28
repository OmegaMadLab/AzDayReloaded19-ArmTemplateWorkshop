configuration DomainJoin {

    param (
        [Parameter(Mandatory)]
        [String]
        $DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$DomainCreds
    )

    # Import modules
    Import-DscResource -ModuleName PSDesiredStateConfiguration, xActiveDirectory, xComputerManagement

    node ("localhost")
    {

        WindowsFeature WebServer
        {
            Ensure = "Present"
            Name = "web-server"
        }

        WindowsFeature ADPS
            {
                Name = "RSAT-AD-PowerShell"
                Ensure = "Present"
            }

        xWaitForADDomain ForestWait 
        { 
            DomainName = $DomainName 
            DomainUserCredential= $DomainCreds
            RetryCount = 20 
            RetryIntervalSec = 30 
            DependsOn = "[WindowsFeature]ADPS"
        }
        
        xComputer DomainJoin
        {
            Name = $env:COMPUTERNAME
            DomainName = $DomainName
            Credential = $DomainCreds
            DependsOn = "[xWaitForADDomain]ForestWait"
        }
    }
}