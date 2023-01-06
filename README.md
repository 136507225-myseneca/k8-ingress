# Building and Deploying a service on Kubeneties using minikube

This sequence assumes

- that your system is configured to access a kubernetes cluster (e. g. [AWS EKS](https://aws.amazon.com/eks/), [kind](https://kind.sigs.k8s.io/), or [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/))
- that your machine has

  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/),
  - [docker](https://docs.docker.com/engine/install/),

    installed and able to access your cluster.

## Note

Ingress does not work that smootly using docker driver on mac and windows check [here](https://minikube.sigs.k8s.io/docs/drivers/docker/)

Run the bellow script

```
.\build.sh

```

- minikube start --vm=true
- minikube addons enable ingress
- minikube addons enable ingress-dns
- docker build --tag node-docker .
- eval $(minikube docker-env)
- kubectl apply -f app.delopyment.yml
- kubectl apply -f app-service.yml
- minikube tunnel
- kubectl apply -f app-ingress.yml

# How would you improve this app in production Environment ?

logs for all the services can be streamed to cloudwatch an external resources Fluent Bit or Fluentd to send logs from your containers to your CloudWatch logs aws conatiner insite can be used for detail monitoring of custer resoures and metics

AWS X-Ray can be used which provides application-tracing functionality, giving deep insights into all microservices deployed. With X-Ray, every request can be traced as it flows through the involved microservices. This provides your DevOps teams the insights they need to understand how your services interact with their peers and enables them to analyze and debug issues much faster.

Services meshes such as AWS App Mesh help you to connect services, monitor your application’s network, and control the traffic flow. When an application is running within a service mesh, the application services are run alongside proxies which form the data plane of the mesh another platform diagnostic is Isto
