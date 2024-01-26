#!/usr/bin/bash

echo '### Update, Upgrading and Installing required packages ###'
echo '##########################################################'
echo '     ###############################################'
sudo apt update && sudo apt upgrade -y
sudo apt install -y pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev git lzma liblzma-dev

echo '### ADD Repository in etc and Installing QGIS SOFTWARE ###'
echo '##########################################################'
echo '     ###############################################'

sudo sh -c 'echo "Types: deb deb-src\nURIs: https://qgis.org/ubuntu-ltr\nSuites: jammy\nArchitectures: amd64\nComponents: main\nSigned-By: /etc/apt/keyrings/qgis-archive-keyring.gpg"  > /etc/apt/sources.list.d/qgis.sources && sudo apt update'
sudo wget https://download.qgis.org/downloads/qgis-archive-keyring.gpg
gpg --no-default-keyring --keyring ./qgis-archive-keyring.gpg --list-keys
sudo cp qgis-archive-keyring.gpg /etc/apt/keyrings/qgis-archive-keyring.gpg
sudo wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg

sudo apt update
sudo apt install qgis qgis-plugin-grass -y

echo '## Installing PostgreSQL Database and Postgis extension ##'
echo '##########################################################'
echo '     ###############################################'

sudo apt install postgresql postgis -y
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'postgres';"

echo '################# Installing PGADMIN4 ####################'
echo '##########################################################'
echo '     ###############################################'

curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && sudo apt update'
sudo apt install pgadmin4 -y

echo '############ Installing Pycharm Communit #################'
echo '##########################################################'
echo '     ###############################################'

sudo snap install pycharm-community --classic

echo '# Installing Pyenv to allow install differents pythons versions #'
echo '##########################################################'
echo '     ###############################################'

username=$(logname)
echo 'export PATH="/home/'$username'/.pyenv/bin:$PATH"'>>/home/$username/.bashrc
echo 'eval "$(pyenv init -)"'>>/home/$username/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"'>>/home/$username/.bashrc
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | sudo -u $username bash

echo "Running DEV set up."
su $username -c "./dev_install.sh"
