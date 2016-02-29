#!/bin/bash

echo -ne "Stoping rc..."
sudo /opt/local/bin/kubectl stop rc -l "name in (redis-master, redis-slave, frontend)" > /dev/null 2>&1
echo -e "Done\n"
sleep 1

echo -ne "Deleting services..."
sudo /opt/local/bin/kubectl delete service -l "name in (redis-master, redis-slave, frontend)" > /dev/null 2>&1
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