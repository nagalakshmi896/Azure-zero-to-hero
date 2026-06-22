# Command to create ACR ImagePullSecret

```
kubectl create secret docker-registry <secret-name> \
    --namespace <namespace> \
    --docker-server=<container-registry-name>.azurecr.io \
    --docker-username=<service-principal-ID> \
    --docker-password=<service-principal-password>
```

```
kubectl create secret docker-registry acr-secret  \
    --namespace default \
    --docker-server=nagacicd.azurecr.io \
    --docker-username=nagacicd \
    --docker-password=FFSq97KbmUA2b6bYm7tn427WqTAH5C0W99feZP6aZ4f6HS2UX0INJQQJ99CFACYeBjFEqg7NAAACAZCRrbfI
```

Note: container registry --> Access keys --> check Admin user box --> It will give Username and Password

Configure Deployment:

```yaml
      imagePullSecrets:
      - name: acr-secret 
```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: vote
  name: vote
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vote
  template:
    metadata:
      labels:
        app: vote
    spec:
      containers:
      - image: nagacicd/votingapp:18
        name: vote
        ports:
        - containerPort: 80
          name: vote
      imagePullSecrets:
      - name: acr-secret    

```
