#!/usr/bin/bash

echo '### Update, Upgrading and Installing required packages ###'
echo '##########################################################'
echo '     ###############################################'
sudo apt update && sudo apt upgrade -y
sudo apt install -y pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev git

echo '### ADD Repository in etc and Installing QGIS SOFTWARE ###'
echo '##########################################################'
echo '     ###############################################'

distro="deb https://qgis.org/ubuntu-ltr $(lsb_release -s -c) main" 
sudo sh -c 'echo "deb https://qgis.org/ubuntu-ltr $(lsb_release -s -c) main"  > /etc/apt/sources.list.d/qgis.list && sudo apt update'
wget -qO - https://qgis.org/downloads/qgis-2021.gpg.key | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import
sudo chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
sudo add-apt-repository "deb https://qgis.org/ubuntu-ltr $(lsb_release -c -s) main"

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
