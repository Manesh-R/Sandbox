#!/bin/bash

wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/setup-cert.sh
chmod +x setup-cert.sh
./setup-cert.sh

pwd
wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/setup-nlp.sh
chmod a+x setup-nlp.sh
chown demouser.demouser setup-nlp.sh
sudo -u demouser ./setup-nlp.sh
