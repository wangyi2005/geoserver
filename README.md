
https://cloud.ibm.com/docs/codeengine?topic=codeengine-deploy-app-tutorial

ibmcloud plugin install code-engine

ibmcloud plugin show code-engine

ibmcloud ce project create --name PROJECT_NAME

ibmcloud ce project select --name PROJECT_NAME

ibmcloud ce project get --name PROJECT_NAME

ibmcloud ce project list

ibmcloud ce application create --name myapp --image ibmcom/hello

ibmcloud ce application get -n myapp

ibmcloud ce application get -n myapp -output url

ibmcloud ce application update --name myapp --env TARGET=Stranger












