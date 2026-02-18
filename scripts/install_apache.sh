#!/bin/bash

yum update -y

yum install -y httpd

systemctl start httpd
systemctl enable httpd

echo "<h1>Project 1: Automated Infrastructure</h1>" > /var/www/html/index.html
echo "<p>Status: <b>Successfully Bootstrapped</b></p>" >> /var/www/html/index.html
echo "<p>Deployed via Terraform in a Private Subnet.</p>" >> /var/www/html/index.html