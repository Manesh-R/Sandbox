deploymentId=${1}
resourceGroupName=${2}
azureUserName=${3}
azureUserPassword=${4}
applicationDisplayName=${5}
applicationSecretKey=${6}
aksName=ignite-$deploymentId

# Install pre-req softwares
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

# Set context
echo "cd /home/labuser" >> /home/labuser/aks-create.sh
echo deploymentId=$deploymentId >> /home/labuser/aks-create.sh
echo resourceGroupName=$resourceGroupName >> /home/labuser/aks-create.sh 
echo azureUserName=$azureUserName >> /home/labuser/aks-create.sh 
echo azureUserPassword=$azureUserPassword >> /home/labuser/aks-create.sh 
echo applicationDisplayName=$applicationDisplayName >> /home/labuser/aks-create.sh 
echo applicationSecretKey=$applicationSecretKey >> /home/labuser/aks-create.sh
echo "aksName=ignite-$deploymentId" >> /home/labuser/aks-create.sh

# Install Azure CLI
echo "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash" >> /home/labuser/aks-create.sh

# Login to azure
echo "az login -u $azureUserName -p $azureUserPassword" >> /home/labuser/aks-create.sh

# Create AKS
echo "applicationId=\`az ad sp list --display-name $applicationDisplayName --query [0].appId --output tsv\`" >> /home/labuser/aks-create.sh
echo "az aks create -n $aksName -g  $resourceGroupName --kubernetes-version 1.14.7 --dns-name-prefix $aksName --node-vm-size Standard_DS2_v2 --node-osdisk-size 30 --node-count 2 --network-plugin kubenet --service-principal \$applicationId  --client-secret $applicationSecretKey  --generate-ssh-keys" >> /home/labuser/aks-create.sh

# Configure Monitorin in aks
echo "workspaceId=\`az resource list --resource-type Microsoft.OperationalInsights/workspaces --query [0].id --output tsv\`" >> /home/labuser/aks-create.sh
echo "az aks enable-addons -a monitoring -n $aksName -g  $resourceGroupName --workspace-resource-id \$workspaceId" >> /home/labuser/aks-create.sh

# Install app in AKS
echo "wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/azure-vote.yaml" >> /home/labuser/aks-create.sh
echo "az aks get-credentials -n $aksName -g $resourceGroupName" >> /home/labuser/aks-create.sh
echo "kubectl get nodes" >> /home/labuser/aks-create.sh
echo "kubectl apply -f azure-vote.yaml" >> /home/labuser/aks-create.sh

cd /home/labuser
chmod 777 /home/labuser/aks-create.sh
chown labuser.labuser /home/labuser/aks-create.sh
runuser -l demouser -c 'sh /home/labuser/aks-create.sh'
