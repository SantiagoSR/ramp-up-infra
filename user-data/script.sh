#!/usr/bin/env bash

sudo apt-get update
sudo curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs -y
sudo curl https://www.npmjs.com/install.sh | sudo sh
sudo apt-get install mysql-server -y
sudo apt-get upgrade -y

sudo git clone https://github.com/SantiagoSR/movie-api.git
sudo git clone https://github.com/SantiagoSR/movies-ui.git

cd movie-api/
sudo npm install express
sudo npm install mysql2
sudo npm install dotenv 
cd ..
cd movies-ui/
sudo npm install express
sudo npm install mysql2
sudo npm install dotenv
cd ..

sudo mv movies-ui/ movie-api/ home/ubuntu/

export DBHOST="localhost"
export DBNAME="movie_db"
export DBUSER="santiago"
export DBPASSWD="lycantropo"

sudo useradd -s /bin/bash -d /home/santiago/ -m santiago