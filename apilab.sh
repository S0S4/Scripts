#!/bin/bash
dir1="CRapi"

# Install packages

sudo apt-get update

[[ $(apt-get -s install docker-compose | grep "already") ]] && echo "" || sudo apt-get install docker-compose -y

[[ $(pip3 list --format=columns | grep "mitm" ) ]] && echo "" || sudo pip3 install mitmproxy2swagger

[[ $(apt-get -s install docker.io | grep "already") ]] && echo "" || sudo apt-get install docker.io -y

[[ $(apt-get -s install golang-go | grep "already") ]] && echo "" || sudo apt-get install golang-go -y

postman_location=find / -name postman 2>/dev/null | wc -l

[[ $postman_location -lt 1 ]] && sudo wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz && sudo tar -xvzf postman-linux-x64.tar.gz -C /opt/ && sudo echo "alias postman="./opt/Postman/Postman"" >> ~/.zshrc && source ~/.zshrc || echo "Postman Instalado"

# Deploy Docker


cd ~/

mkdir APILab && cd APILab && mkdir $dir1


curl -o ~/APILab/$dir1/docker-compose.yml https://raw.githubusercontent.com/OWASP/crAPI/main/deploy/docker/docker-compose.yml


cd $dir1 && sudo docker-compose pull && sudo docker-compose -f docker-compose.yml --compatibility up -d

git clone https://github.com/roottusk/vapi.git ~/APILab/vapi/

cd ~/APILab/vapi && sudo docker-compose up -d
