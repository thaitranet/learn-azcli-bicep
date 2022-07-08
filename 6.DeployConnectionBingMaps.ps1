param(
    [Parameter(Mandatory)]
    [string]$ApiKey
)

. .\GlobalParameters.ps1

az deployment group create `
--name $ConnectionBingMapsDeploymentName `
--resource-group $ResourceGroupName `
--template-file $ConnectionBingMapsTemplateFile `
--parameters apiKey=$ApiKey