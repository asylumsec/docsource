#!/bin/bash
sudo docker stop $(sudo docker ps -a |grep gov-docs | awk '{print $1}')
sudo docker rm $(sudo docker ps -a |grep gov-docs | awk '{print $1}')
