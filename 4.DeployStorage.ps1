. .\GlobalParameters.ps1

az storage account create `
-n $LogicAppStorageAccountName `
-g $ResourceGroupName `
-l $Location `
--sku $LogicAppStorageAccountSku

$StorageAccountConnectionString = (az storage account show-connection-string `
-g $ResourceGroupName `
-n $LogicAppStorageAccountName --output tsv)

az storage table create `
--name $LogicAppTableName `
--connection-string $StorageAccountConnectionString