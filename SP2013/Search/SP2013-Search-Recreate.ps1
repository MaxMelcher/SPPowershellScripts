Add-PSSnapin Microsoft.SharePoint.Powershell -EA 0
$ServiceApplication = Get-SPEnterpriseSearchServiceApplication
$SearchTopology = $ServiceApplication | New-SPEnterpriseSearchTopology
$SearchInstance = Get-SPEnterpriseSearchServiceInstance
$IndexLocation = "c:\SearchIndex"

New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance
New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance
New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance
New-SPEnterpriseSearchCrawlComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance 
New-SPEnterpriseSearchAdminComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance
New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance
 
set-SPEnterpriseSearchAdministrationComponent -SearchApplication $ServiceApplication -SearchServiceInstance  $SearchInstance
 
Remove-Item -Recurse -Force -LiteralPath $IndexLocation -ErrorAction SilentlyContinue
mkdir -Path $IndexLocation -Force 
 
New-SPEnterpriseSearchIndexComponent -SearchTopology $SearchTopology -SearchServiceInstance $SearchInstance -RootDirectory $IndexLocation 
 
Write-Host -ForegroundColor Yellow "Activating new topology"
$SearchTopology.Activate()
Write-Host -ForegroundColor Green "Activated new topology"