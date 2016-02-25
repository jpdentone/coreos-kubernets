#!/bin/bash

echo -ne "Removing old stuff..."
rm -rf ../certs/ca-key.pem
rm -rf ../certs/ca.pem
echo -e "Done\n"

echo -ne "Setting up key..."
openssl genrsa -out ../certs/ca-key.pem 2048 > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up pem..."
openssl req -x509 -new -nodes -key ../certs/ca-key.pem -days 10000 -out ../certs/ca.pem -subj "/CN=kube-ca" > /dev/null 2>&1
echo -e "Done\n"
