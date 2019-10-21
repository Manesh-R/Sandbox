service jupyterhub stop
wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/jupyterhub_config.py
cp jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py -f
wget https://raw.githubusercontent.com/Manesh-R/Sandbox/test/ms-cloudlabs.ai.tar.gz
tar -zxvf ms-cloudlabs.ai.tar.gz
cp ssl/privkey.pem /etc/jupyterhub/srv/server.key -f
cp ssl/fullchain.pem /etc/jupyterhub/srv/server.crt -f
service jupyterhub start
