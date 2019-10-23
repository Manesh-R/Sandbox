cd /home/demouser
cd notebooks
git clone https://github.com/microsoft/nlp.git
cd nlp
git checkout origin/ignite
python tools/generate_conda_file.py --gpu
export PATH=$PATH:/data/anaconda/envs/py35/bin
/data/anaconda/envs/py35/bin/conda env create -n nlp_gpu -f nlp_gpu.yaml
source /anaconda/etc/profile.d/conda.sh
conda activate nlp_gpu
python -m ipykernel install --user --name nlp_gpu --display-name "nlp_gpu"
pip install -e .
python3 setup.py bdist_wheel
