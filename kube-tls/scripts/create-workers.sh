#!/bin/bash

echo -ne "Removing old stuff..."
rm -rf ../certs/worker*
echo -e "Done\n"

echo -ne "Setting up key..."
openssl genrsa -out ../certs/worker-key.pem 2048 > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up csr..."
openssl req -new -key ../certs/worker-key.pem -out ../certs/worker.csr -subj "/CN=kube-minion" > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up pem..."
openssl x509 -req -in ../certs/worker.csr -CA ../certs/ca.pem -CAkey ../certs/ca-key.pem -CAcreateserial -out ../certs/worker.pem -days 365 > /dev/null 2>&1
echo -e "Done\n"