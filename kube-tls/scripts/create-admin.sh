#!/bin/bash

echo -ne "Removing old stuff..."
rm -rf ../certs/admin*
echo -e "Done\n"

echo -ne "Setting up key..."
openssl genrsa -out ../certs/admin-key.pem 2048 > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up csr..."
openssl req -new -key ../certs/admin-key.pem -out ../certs/admin.csr -subj "/CN=kube-admin" > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up pem..."
openssl x509 -req -in ../certs/admin.csr -CA ../certs/ca.pem -CAkey ../certs/ca-key.pem -CAcreateserial -out ../certs/admin.pem -days 365 > /dev/null 2>&1
echo -e "Done\n"
