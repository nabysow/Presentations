$rootPath = "C:\Users\sstad\source\repos\Other\Presentations\Solving the Dev DB problem with Docker and dbaclone"

###############################################################
# Import the modules
###############################################################
Import-Module dbatools
Import-Module dbaclone

###############################################################
# Build the project
###############################################################

# Setting environment varibles
$msbuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"

$projectFile = Join-Path -Path $rootPath -ChildPath "SSDT\StackOverflow2013\StackOverflow2013-Tests\StackOverflow2013-Tests.sqlproj"

# Running build
.  $msbuildPath $projectFile

###############################################################
# Deploy database
###############################################################

$SqlInstance = "localhost"
$SqlCredential = $null
$Database = "StackOverflow2013"

$dacpacPath = Join-Path -Path $rootPath -ChildPath "SSDT\StackOverflow2013\StackOverflow2013-Tests\bin\Debug\StackOverflow2013-Tests.dacpac"
$publishProfilePath = Join-Path -Path $rootPath -ChildPath "SSDT\StackOverflow2013\StackOverflow2013-Tests\StackOverflow2013-Tests.publish.xml"

$params = @{
    SqlInstance   = $SqlInstance
    SqlCredential = $SqlCredential
    Database      = $Database
    Path          = $dacpacPath
    PublishXml    = $publishProfilePath
}

Publish-DbaDacPackage @params