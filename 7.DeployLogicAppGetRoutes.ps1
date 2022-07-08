. .\GlobalParameters.ps1

az deployment group create `
--name $GetRoutesDeploymentName `
--resource-group $ResourceGroupName `
--template-file $GetRoutesTemplateFile `
--parameters workflowsName=$GetRoutesWorkflowsName