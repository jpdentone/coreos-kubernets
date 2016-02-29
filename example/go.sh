#!/bin/bash

echo -ne "Create redis-master rc..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/redis-master-controller.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Create redis-master service..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/redis-master-service.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Create redis-slave rc..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/redis-slave-controller.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Create redis-slave service..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/redis-slave-service.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Create frontend rc..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/frontend-controller.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Create frontend service..."
sudo /opt/local/bin/kubectl create -f kubernetes/example/frontend-service.yaml > /dev/null 2>&1
echo -e "Done\n"
sleep 1


echo -e "\n============ Get RCs ==========\n"
sleep 1
/opt/local/bin/kubectl get rc
sleep 2

echo -e "\n============ Get Pods ==========\n"
sleep 1
/opt/local/bin/kubectl get pods
sleep 2

echo -e "\n============ Get Services ==========\n"
sleep 1
/opt/local/bin/kubectl get services
sleep 2