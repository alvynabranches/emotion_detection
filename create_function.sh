az group create --name emotion_group --location canadacentral

az appservice plan create \
  --name emotion_plan \
  --resource-group emotion_group \
  --sku S1 \
  --is-linux

az storage account create \
  --name emotion_storage \
  --resource-group emotion_group \
  --location canadacentral \
  --sku Standard_LRS

az functionapp create \
    --resource-group emotion_group \
    --name emotion \
    --storage-account emotion_storage \
    --plan emotion_plan \
    --image emotion1.azurecr.io/emotion:latest \
    --functions-version 4 \
    --os-type Linux

az functionapp update \
    --name emotion \
    --resource-group emotion_group \
    --set containerSettings.image=emotion1.azurecr.io/emotion:latest