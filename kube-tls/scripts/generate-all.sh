#!/bin/bash

echo -e "\n============ Generating CA ==========\n"
sleep 1
./create-ca.sh


echo -e "\n============ Generating API ==========\n"
sleep 1
./create-api.sh


echo -e "\n============ Generating WORKERS ==========\n"
sleep 1
./create-workers.sh


echo -e "\n============ Generating ADMIN ==========\n"
sleep 1
./create-admin.sh
