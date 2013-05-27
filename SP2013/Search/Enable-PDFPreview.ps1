$tenantOwner = Get-SPEnterpriseSearchOwner -Level SSA
$ssa = "Search Service Application" #adjust if you renamed the service application

$rule = get-SPEnterpriseSearchPropertyRule -PropertyName "FileType" -Operator "IsEqual"
$rule.AddValue( "pdf" )
$ruleCollection = Get-SPEnterpriseSearchPropertyRuleCollection
$ruleCollection.Add($rule)

$item = new-SPEnterpriseSearchResultItemType -Owner $tenantOwner -SearchApplication $ssa -Name "PDF with Preview" -Rules $ruleCollection -RulePriority 1 -DisplayProperties "Title,Author,Size,Path,Description,EditorOWSUSER,LastModifiedTime,CollapsingStatus,DocId,HitHighlightedSummary,HitHighlightedProperties,FileExtension,ViewsLifeTime,P
                         arentLink,ViewsRecent,FileType,IsContainer,SecondaryFileExtension,DisplayAuthor,docaclmeta,ServerRedirectedURL,SectionNames,SectionIndexes,ServerRedirectedEmbedURL,S
                         erverRedirectedPreviewURL" -DisplayTemplateUrl "~sitecollection/_catalogs/masterpage/Display Templates/Search/Item_Word.js" -OptimizeForFrequentUse $true 