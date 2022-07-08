$Prefix="demoapp"
$Suffix="0708"

$Location="australiasoutheast"

$ResourceGroupName="$($Prefix)rg$($Suffix)"

$LogicAppStorageAccountName="$($Prefix)storage$($Suffix)"
$LogicAppStorageAccountSku="Standard_LRS"
$LogicAppTableName="bingmaps"

$ConnectionStorageDeploymentName="deployconnectionstorage"
$ConnectionStorageTemplateFile=".\templates\deployconnectionstorage.template.bicep"

$ConnectionBingMapsDeploymentName="deployconnectionbingmaps"
$ConnectionBingMapsTemplateFile=".\templates\deployconnectionbingmaps.template.bicep"

$GetRoutesWorkflowsName="$($Prefix)getroutes$($Suffix)"
$GetRoutesDeploymentName="deploylogicappgetroutes"
$GetRoutesTemplateFile=".\templates\deploylogicappgetroutes.template.bicep"

$SendRoutesWorkflowsName="$($Prefix)sendroutes$($Suffix)"
$SendRoutesDeploymentName="deploylogicappsendroutes"
$SendRoutesTemplateFile=".\templates\deploylogicappsendroutes.template.bicep"