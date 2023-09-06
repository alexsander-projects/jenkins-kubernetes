# jenkins-kubernetes

Here we will see how to install jenkins on kubernetes, and use it to create pods on the fly to run jobs.

We will also create a volume so that we can persist data if the pod is deleted.

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/Architecture.png)
>`Architecture`

All the `yaml` files used can be found in this repository.

## Jenkins Kubernetes deployment

In this deployment we used:

1. 'securityContext' for Jenkins pod to be able to write to the local persistent volume;

2. Liveness and readiness probe to monitor the health of the Jenkins pod;

3. Local persistent volume based on local storage class that holds the Jenkins data path '/var/jenkins_home'.

## Kubernetes setup

- First, create an AKS cluster on Azure;

- Now, connect to the kubernetes cluster;

To do it using CLI, first log in:

    az login

Set the cluster subscription:

    az account set --subscription <subscription id>

Download cluster credentials

    az aks get-credentials --resource-group <resource group name> --name <kubernetes service name>

- Now setup Jenkins on Kubernetes;

- First create a `serviceAccount.yaml` file:

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/serviceAccount.yaml.png)
>`serviceAccount.yaml`

Run:

    kubectl apply -f serviceAccount.yaml    

- Create a `volume.yaml` file:

Replace `worker-node` with any one of your cluster worker nodes hostname;

You can get the worker node hostname with:

    kubectl get nodes   

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/volume.yaml.png)
>`volume.yaml`

Run:

    kubectl create -f volume.yaml   

Create a `deployment.yaml` file:

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/deployment.yaml.png)
>`deployment.yaml`

Run:

    kubectl apply -f deployment.yaml    

You can get the deployment details with:

    kubectl describe deployments --namespace=<namepace> 

Create a `service.yaml` file, this will be of type `LoadBalancer`:

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/volume.yaml.png)
>`service.yaml`

Create the Jenkins service:

    kubectl apply -f service.yaml   

## Jenkins Configuration

- You can access Jenkins with:

address:

    http://<node-ip>:8080

You can also get the control plane address with:

    kubectl cluster-info    

- Procede with the basic Jenkins configuration;

Get the initial password with:

    kubectl get pods --namespace=<namepace> 
>to get the pod name

and then:

    kubectl logs <pod name> --namespace=<namepace>  

- Create the admin user and install `kubernetes` plugin;

## Kubernetes Plugin Configuration

- Now, with the plugin installed, create a new cloud of type `kubernetes`;

- Name it;

- On Kubernetes URL,

set the control plane address, you can get it with:

    kubectl cluster-info    

- Test the connection;

- Set the namespace, the one that you used on `serviceAccount.yaml` file;

- Enable `WebSocket`;

## Jenkins job

- Now create a new pipeline job, the `jenkinsfile` can be found in this repository;

- The jenkinsfile will create two containers based on docker images, upon running the pipeline, it will spin up pods, run the script, and purge the pods.

![](https://github.com/myProjects175/jenkins-kubernetes/blob/72f326370f5153632124550fefa0dea0c9776c9f/images/jenkinsfile.png)
>`jenkinsfile`