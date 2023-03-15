#/bin/bash

root_dir=$(pwd)
echo "Setting up the environment in the $root_dir"

# create and activate the virtual environment
echo "Creating a virtual environment with python3"
conda create -n itv2 python=3.9
conda activate itv2

echo "Installing all the dependencies"
python3 -m pip install --upgrade pip

# install pytorch (latest)
python3 -m pip install torch --extra-index-url https://download.pytorch.org/whl/cu116

# install indic-nlp-library and necessary resources
git clone https://github.com/anoopkunchukuttan/indic_nlp_resources.git
export INDIC_RESOURCES_PATH=$root_dir/indic_nlp_resources

git clone https://github.com/anoopkunchukuttan/indic_nlp_library.git
cd indic_nlp_library
python3 -m pip install ./


# additional packages for utilies
python3 -m pip install sacremoses pandas mock sacrebleu urduhack[tf] mosestokenizer
python3 -c "import urduhack; urduhack.download()"

# install sentence piece for tokenization
# uncoment the below line to install sentencepiece binaries
# sudo apt install sentencepiece
python3 -m pip install sentencepiece

# install fairseq from source
git clone https://github.com/pytorch/fairseq.git
cd fairseq
python3 -m pip install ./

cd $root_dir
echo "Setup completed!"