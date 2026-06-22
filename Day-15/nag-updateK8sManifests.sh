#!/bin/bash

set -x

# Set the repository URL (we should not pass token here, we need to use command line like $4 like how we pass below)
# this PAT should have required permissions to made changes (don't use argocd PAT, it is just having read permission)
REPO_URL="https://4QDWVDCI33vVrQAoxir24Hq8XN8aaPzRFytllDoWQOe7vIf2cMOJJQQJ99CFACAAAAAAAAAAAAASAZDO3KBw@dev.azure.com/nagalakshmi896/student/_git/student"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: nagacicd.azurecr.io/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo
