#!/bin/bash

clear
echo -e "\033[44;37m********************************************\033[0m"
echo -e "\033[44;37m***  PoC Challenge - Networking Group 0  ***\033[0m"
echo -e "\033[44;37m***    Terraform deploy & destroy tool   ***\033[0m"
echo -e "\033[44;37m********************************************\033[0m"
echo -e "\033[42;30m1. Deploy VPCs and EC2 instances.\033[0m"
echo -e "\033[42;30m2. Deploy VPC-Peering connections.\033[0m"
echo -e "\033[42;30m3. Deploy Transit Gateway connections.\033[0m"
echo -e "\033[41;37m4. Destroy VPCs and EC2 instances.\033[0m"
echo -e "\033[41;37m5. Destroy VPC-Peering connections.\033[0m"
echo -e "\033[41;37m6. Destroy Transit Gateway connections.\033[0m"
echo -e "\033[45;37m0. Exit.\033[0m"
opt=9
while (($opt != 0))
read -p "Please choose operations:" opt
do
    if (($opt == 1))
    then
        echo "Deploying VPCs and EC2 instances..."
        cd vpc
        terraform init
        terraform apply -auto-approve
        cd ..
    elif (($opt == 2))
    then
        echo "Deploying VPC-Peering connections..."
        cd vpc-peering
        terraform init
        terraform apply -auto-approve
        cd ..
    elif (($opt == 3))
    then
        echo "Deploying Transit Gateway connections..."
        cd transit-gateway
        terraform init
        terraform apply -auto-approve
        cd ..
    elif (($opt == 4))
    then
        echo "Destroying VPCs and EC2 instances..."
        cd vpc
        terraform destroy -auto-approve
        cd ..
    elif (($opt == 5))
    then
        echo "Destroying VPC-Peering connections..."
        cd vpc-peering
        terraform destroy -auto-approve
        cd ..
    elif (($opt == 6))
    then
        echo "Destroying Transit Gateway connections..."
        cd transit-gateway
        terraform destroy -auto-approve
        cd ..
    elif (($opt == 0))
    then
        exit 0
    else
        echo "Input error, please check options and try again."
    fi
done
