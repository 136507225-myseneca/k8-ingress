#!/bin/bash

Red='\033[0;31m'
Green='\033[0;32m'        
Yellow='\033[0;33m'       
Blue='\033[0;34m'

echo "Starting minikube..."

/usr/local/bin/minikube  start

echo "enabling  minikube ingress ..."

/usr/local/bin/minikube  addons enable ingress

/usr/local/bin/minikube addons enable ingress-dns

echo -e " ${Blue} ########################################################

## Building docker image    

#######################################################"

eval $(minikube docker-env)

docker build --tag node-docker .

echo -e "${Green}########################################################

## Build successful     

#######################################################"


cd deployments

echo -e "${Blue}########################################################

## Running Deploymnet  Manifest 

#######################################################"

kubectl apply -f app.deploymnet.yml

echo -e "${Green}########################################################

##  successful     

#######################################################"


echo -e "${Blue}########################################################

## Running Service  Manifest 

#######################################################"

kubectl apply -f app-service.yml

echo -e "${Green}########################################################

##  successful     

#######################################################"




echo -e "${Blue}########################################################

## Running Ingress  Manifest 

#######################################################"

kubectl apply -f app-ingress.yml

echo -e "${Green}########################################################

##  successful     

#######################################################"


kubectl get ingress


echo -e "${Blue}########################################################

## adding bar.local to /etc/hosts

#######################################################"

IP="127.0.0.1"

 HOSTNAME="bar.local"
 ETC_HOSTS=/etc/hosts



    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi


echo -e "${Blue}########################################################

## minikube tunnel 

#######################################################"

echo "Enter password:"
read -s password

echo $password | minikube tunnel &

echo "minikube tunnel running in the background"

echo -e "${Blue}########################################################

## Checking if service is up and running 

#######################################################"


url="http://bar.local/foo"

# Use curl to check if the URL is up
curl --head --silent --fail "$url" > /dev/null

# Check the exit code of the curl command
if [ $? -eq 0 ]; then
  echo -e "${Green}$url is up visit http://bar.local/foo on your browser"
  
else
  echo -e "${down}$url is down run minikube tunnel"
fi






