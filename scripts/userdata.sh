#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Welcome to $(hostname) - NGINX Installed via Terraform</h1>" | sudo tee /var/www/html/index.html
