. .\GlobalParameters.ps1

az deployment group create `
--name $ConnectionStorageDeploymentName `
--resource-group $ResourceGroupName `
--template-file $ConnectionStorageTemplateFile `
--parameters storageAccountName=$LogicAppStorageAccountName