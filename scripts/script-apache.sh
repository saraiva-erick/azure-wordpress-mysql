#!/bin/bash

echo "Atualizando o servidor"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install apache2 -y
sudo apt-get install unzip -y
sudo apt-get install wget -y

echo "Baixando arquivo da aplicação"
cd /tmp
sudo wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
sudo unzip main.zip
cd linux-site-dio-main
sudo cp -R * /var/www/html

echo "Termino do script"