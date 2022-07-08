. .\GlobalParameters.ps1

az deployment group create `
--name $SendRoutesDeploymentName `
--resource-group $ResourceGroupName `
--template-file $SendRoutesTemplateFile `
--parameters workflowsName=$SendRoutesWorkflowsName