# Login
Add-AzAccount

# Retrieve information for disks
start-process -FilePath https://docs.microsoft.com/en-us/azure/templates/ -WindowStyle Maximized

# Retrieve information about VM Images
Get-AzVmImagePublisher -location "WestEurope"
Get-AzVmImageOffer -PublisherName "MicrosoftWindowsServer" -location "WestEurope"
Get-AzVmImageSku -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"
Get-AzVmImageSku -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"

# Deployment
$rgName = "AzDayTeacher-RG"
$templateFileName = ".\TemplateUpdated\template_v6.json"
$parameterFileName = ".\TemplateUpdated\parameters_v6_test.json"
New-AzResourceGroupDeployment -ResourceGroupName $rgName `
    -TemplateFile $templateFileName `
    -TemplateParameterFile $parameterFileName
