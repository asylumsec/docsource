#!/bin/bash
echo "Hi, "$USER". This project uses docker for development."
echo "Please ensure you have docker installed, setup and running."
echo "This script is designed for linux machines"
echo "This project uses github to host the docs, and I need some information on your account"
echo "What is you github email address [ENTER]:"
echo "What is your sudo password [ENTER]:"
read -s sudopass
echo $sudopass |sudo -S docker run -dit --name gov-docs -p 127.0.0.1:8080:8080 fedora:latest /bin/bash 
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/dnf -y install npm ruby git gcc gcc-c++ make ruby-devel redhat-rpm-config rsync procps-ng
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/gem install ascii_binder
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/npm install http-server -g
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/mkdir /docs
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/git clone https://github.com/RedHatGov/docs-source.git /docs/docs-source
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/git clone https://github.com/RedHatGov/redhatgov.github.io.git /docs/redhatdod.github.io
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/git config --system credential.helper store
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/git config --system credential.helper 'cache --timeout 86400'
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/cp /docs/docs-source/deploydocs /usr/bin
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/cp /docs/docs-source/devdocs /usr/bin
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/cp /docs/docs-source/devserver /usr/bin
sudo docker stop $(sudo docker ps -a|grep gov-docs |awk '{print $1}')
sudo docker start $(sudo docker ps -a|grep gov-docs |awk '{print $1}')
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /usr/bin/devserver
sudo docker exec -it $(sudo docker ps |grep gov-docs |awk '{print $1}') /bin/bash -c 'cd /docs/docs-source ; exec "${SHELL:-sh}"'
