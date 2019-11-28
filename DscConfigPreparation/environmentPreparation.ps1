# Set execution policy to unrestriced for demo
Set-ExecutionPolicy "Unrestricted"

# Create a subdirectory to contain DSC config and resources
New-Item .\DscConfig -ItemType Directory

# Look for DSC resources related to AD
Start-Process -filepath "https://www.powershellgallery.com/" -WindowStyle Maximized

# Download xActiveDirectory module from PSGallery
Save-Module -Name xActiveDirectory -Path .\DscConfig
Save-Module -Name xComputerManagement -Path .\DscConfig

# Install and import xActiveDirectory
Install-Module xActiveDirectory
Import-DscResource xActiveDirectory

# Create DSC config
New-Item .\DscConfig\dscConfig.ps1 -ItemType File
code .\DscConfig\dscConfig.ps1

# Once DSC configuration is completed, zip the folder
Compress-Archive -Path .\DscConfig\* -DestinationPath .\DscConfig.zip

# From Azure Portal, create a new container on storage account with Storage Explorer Preview and upload the file
# Take note of the blob URL, to use it inside ARM Template