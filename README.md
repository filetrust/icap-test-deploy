# icap-test-deploy

- [icap-test-deploy](#icap-test-deploy)
    - [Deploying Clusters](#deploying-clusters)
    - [Get context for deployed clusters](#get-context-for-deployed-clusters)
    - [Add secrets to the scripts](#add-secrets-to-the-scripts)
    - [Log into Argocd](#log-into-argocd)
    - [Deploy services](#deploy-services)
    - [Updated DNS names](#updated-dns-names)
    - [Updating changes from argo](#updating-changes-from-argo)

### Deploying Clusters

Use the followin to deploy

```bash
terraform init
```

```bash
terraform apply
```

### Get context for deployed clusters

If you run the script in `./scripts/kube-context/get-kube-context.sh` then this will add all the deployed clusters contexts to your `kubectl`.

```bash
./scripts/kube-context/get-kube-context.sh
```

### Add secrets to the scripts

Next you will need to run the script to create the namespaces and add the secrets.

Before running the script you need to create the certificates

Below is what needs to be entered into the fields:

```
Country Name = GB
State or Province Name = London
Locality Name = London
Organization Name = Glasswall
Operational Unit name = Glasswall Solutions
Common Name (NORTH EUROPE) = icap-client.northeurope.cloudapp.azure.com
Common Name (UK South) = icap-client.uksouth.cloudapp.azure.com
Email Address = Support@glasswallsolution.com

Management-UI
Common Name (NORTH EUROPE) = management-ui.northeurope.cloudapp.azure.com
Common Name (UK South) = management-ui.uksouth.cloudapp.azure.com
```

NEU Certs
```bash
(cd ./certs/neu/icap-cert; openssl req -newkey rsa:2048 -nodes -keyout tls.key -x509 -days 365 -out certificate.crt)

(cd ./certs/neu/mgmt-cert; openssl req -newkey rsa:2048 -nodes -keyout tls.key -x509 -days 365 -out certificate.crt)

```

UKS Certs
```bash
(cd ./certs/uks/icap-cert; openssl req -newkey rsa:2048 -nodes -keyout tls.key -x509 -days 365 -out certificate.crt)

(cd ./certs/uks/mgmt-cert; openssl req -newkey rsa:2048 -nodes -keyout tls.key -x509 -days 365 -out certificate.crt)
```

Now run the script below:

```bash
./scripts/k8_scripts/create-ns-docker-secret.sh
```

### Log into Argocd
Firstly you will need to make sure you have logged into the argocd server through the argo cli. 

To do this follow the commands below:

```bash
kubectl config use-context icap-test-argocd-central
```

```bash
kubeectl get svc -A
```

Then copy the public ip next to `argocd-server`

Next run: 
```bash
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
```

The output of this command is the password for the login section.

Then run:

```bash
argocd login <public ip> --name <context name>
```

Hit yes and then use the username `admin` and password from the output above.

You will now be logged in via the CLI and this will mean the scripts for deployment will execute correctly.

If you want to access the GUI, then paste the IP address into your browser and use the same `admin` and password previously.

### Deploy services

To deploy the nginx chart using the below:

```bash
kubectl config use-context icap-test-aks-uks

helm install ./ingress-nginx -n ingress-nginx 
```

```bash
kubectl config use-context icap-test-aks-neu

helm install ./ingress-nginx -n ingress-nginx
```

Next run the argocd script:

```bash
./scripts/argocd_scripts/argocd-app-deploy.sh
```

Once they're deployed you can run the following to sync them:

```bash
argocd app list -o name | xargs argocd app sync
```

This will sync all the apps and deploy the services to the clusters.

### Updated DNS names

When you deploy you will need to update the DNS names, easiest way to do that is the edit the following files and fields

To update the icap-client dns, you will need to edit `frontend-icap-lb` service and change the following field to something unique:

```bash
service.beta.kubernetes.io/azure-dns-label-name: icap-client-<unique name>
```

### Updating changes from argo

To sync any changes made to the branch into the cluster, you will need to use the following:

If it is a specific app, then list the apps and copy the app name you wish to sync

```bash
argocd app list -o name
```

Now run this command:

```bash
argocd app sync <app name>
```

You can add multiple app names one after anoher and it will sync then together.
