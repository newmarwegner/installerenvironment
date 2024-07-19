#!/usr/bin/bash
export PATH="/home/$USER/.pyenv/bin:$PATH"
eval "$(/home/$USER/.pyenv/bin/pyenv init -)"
eval "$(/home/$USER/.pyenv/bin/pyenv virtualenv-init -)"
echo '######## Installing Python 3.9.0 and set as global #######'
echo '##########################################################'
echo '     ###############################################'
username=$(logname)
pyenv install 3.12.0
pyenv global 3.12.0

echo '### Adding function to bashrc to automate venv activate ###'
echo '##########################################################'
echo '     ###############################################'
#Setting auto activate virtualenv when enter inside of directory
## credits to https://gist.github.com/codysoyland/2198913
cat >>/home/$username/.bashrc << 'EOF'
_virtualenv_auto_activate() {
    if [ -e ".venv" ]; then
         #Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo Activating virtualenv \"$_VENV_NAME\"...
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
            _OLD_VIRTUAL_PS1="$PS1"
            PS1="($_VENV_NAME)$PS1"
            export PS1
        fi
    fi
}

export PROMPT_COMMAND=_virtualenv_auto_activate
EOF

echo '## Creating a basic venv project and install useful sources with pip ##'
echo '##########################################################'
echo '     ###############################################'
mkdir -m 760 /home/$username/Downloads/python_projects
mkdir -m 760 /home/$username/Downloads/python_projects/basic_env
cd /home/$username/Downloads/python_projects/basic_env/
python -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install jupyterlab
pip install pandas
pip install geopandas
pip install matplotlib
pip install rasterio
pip install Shapely

echo "Setup DEV Finished, good luck and enjoy."
