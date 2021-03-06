# Automate bash installer   
Bash file to install gis and dev softwares in Ubuntu 20.04.

### Softwares that will be installed:
- QGIS
- PostgreSQL
- Postgis
- PgAdmin4
- Pycharm
- Pyenv
- Python 3.9.0

At the end of process will be created a virtualenv with pip installed packages as:
- jupyter lab
- pandas
- geopandas
- matplotlib
- rasterio
- Shapely


  ** The script insert a function in bachrc to automate venv activate when 
  inside a folder has a .venv folder**

## Steps to execute:
1. Open terminal
2. Clone Repo   
3. Go into /script_to_run
4. Set permissions to bashes files
5. run first gis_install.sh
6. Close terminal and reopen a new one
7. Run dev_install.sh

## Codes
```
git clone https://github.com/newmarwegner/installerenvironment.git
cd /script_to_run
chmod +x gis_install.sh dev_install.sh
./gis_install.sh
**!!!Atention!!! Close terminal and reopen to run the next codes**
cd /scripti_to_run
./dev_install
```
