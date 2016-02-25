#!/bin/bash

echo -ne "Removing old stuff..."
rm -rf ../certs/api*
echo -e "Done\n"

echo -ne "Setting up key..."
openssl genrsa -out ../certs/apiserver-key.pem 2048 > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up csr..."
openssl req -new -key ../certs/apiserver-key.pem -out ../certs/apiserver.csr -subj "/CN=kube-apiserver" -config ../conf/openssl.cnf > /dev/null 2>&1
echo -e "Done\n"

echo -ne "Setting up pem..."
openssl x509 -req -in ../certs/apiserver.csr -CA ../certs/ca.pem -CAkey ../certs/ca-key.pem -CAcreateserial -out ../certs/apiserver.pem -days 365 -extensions v3_req -extfile ../conf/openssl.cnf > /dev/null 2>&1
echo -e "Done\n"
