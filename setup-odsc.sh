cd /home/labuser/notebooks

git clone -b odsc https://github.com/microsoft/nlp.git
sleep 30
cd nlp
python tools/generate_conda_file.py
conda env create -n nlp_cpu -f nlp_cpu.yaml
source /anaconda/etc/profile.d/conda.sh
conda activate nlp_cpu
python -m ipykernel install --user --name nlp_cpu --display-name "nlp_cpu"

python3.6 -m pip install --upgrade azureml-sdk==1.0.53
