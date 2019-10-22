#!/bin/bash

wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/setup-cert.sh
chmod +x setup-cert.sh
./setup-cert.sh

sudo -u demouser git clone https://github.com/microsoft/nlp.git /home/demouser/notebooks/nlp
cd /home/demouser/notebooks/nlp
sudo -u demouser git checkout origin/ignite
sudo -u demouser python tools/generate_conda_file.py --gpu
sudo -u demouser conda env create -n nlp_gpu -f nlp_gpu.yaml
sudo -u demouser conda activate nlp_gpu
python -m ipykernel install --user --name nlp_gpu --display-name "nlp_gpu"
pip install -e .
python3 setup.py bdist_wheel
#pwd
#wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/setup-nlp.sh
#chmod a+x setup-nlp.sh
#chown demouser.demouser setup-nlp.sh
#sudo -u demouser ./setup-nlp.sh
