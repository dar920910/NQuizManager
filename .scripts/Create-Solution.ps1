$repo = "NQuizManager"
Write-Host "`n*** $repo : Create Solution and Projects ***`n"
dotnet new sln --name $repo

$targetFramework = "net8.0"

$coreLibraryProject = "$repo.Core"
Write-Host "`n--- $coreLibraryProject ---`n"
dotnet new classlib --framework $targetFramework --name $coreLibraryProject
dotnet sln add $coreLibraryProject

$coreUnitTestingProject = "$repo.Core.UnitTests"
Write-Host "`n--- $coreUnitTestingProject ---`n"
dotnet new xunit --framework $targetFramework --name $coreUnitTestingProject
dotnet add $coreUnitTestingProject reference $coreLibraryProject
dotnet sln add $coreUnitTestingProject

$wpfApplicationProject = "$repo.App.WPF"
Write-Host "`n--- $wpfApplicationProject ---`n"
dotnet new wpf --framework $targetFramework --name $wpfApplicationProject
dotnet add $wpfApplicationProject reference $coreLibraryProject
dotnet sln add $wpfApplicationProject

Write-Host "`n*** $repo : Print Solution's Projects ***`n"
dotnet sln list

$analyzerPackage = "StyleCop.Analyzers"
$analyzerVersion = "1.1.118"

$analyzerConfigFileName = "stylecop.json"
$analyzerConfigContent = @"
{
    "`$schema": "https://raw.githubusercontent.com/DotNetAnalyzers/StyleCopAnalyzers/master/StyleCop.Analyzers/StyleCop.Analyzers/Settings/stylecop.schema.json",
    "settings": {
        "documentationRules": {
            "companyName": "Demo Projects Workshop",
            "copyrightText": "Copyright (c) {companyName}. All rights reserved.\nLicensed under the {licenseName} license. See {licenseFile} file in the project root for full license information.",
            "variables": {
                "licenseName": "MIT",
                "licenseFile": "LICENSE.md"
            },
            "headerDecoration": "---------------------------------------------------------------------------"
        }
    }
}
"@

$solutionProjects = @(
    "NQuizManager.App.WPF",
    "NQuizManager.Core",
    "NQuizManager.Core.UnitTests"
)

$homeDirectoryPath = Get-Location

foreach ($project in $solutionProjects) {
    $projectFilePath = "$homeDirectoryPath/$project/$project.csproj"

    if (Test-Path -Path $projectFilePath) {
        Write-Host "$projectFilePath : Configuring StyleCop Analyzers ..."

        dotnet add $projectFilePath package $analyzerPackage --version $analyzerVersion

        $analyzerConfigFilePath = "$homeDirectoryPath/$project/$analyzerConfigFileName"
        Set-Content -Path $analyzerConfigFilePath -Value $analyzerConfigContent
    }
    else {
        Write-Host "$projectFilePath : Cannot detect a project in this folder !"
    }

    Write-Host
}
