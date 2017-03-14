#!/bin/bash

#Update the APT Repository
sudo apt-get update -y

#Installing Git For further Operations
sudo apt-get install git -y

#Clone the forked repository or the original repository
if [ -z $1]
then
    exercismRepo="https://github.com/exercism/exercism.io.git"
else
    exercismRepo="$1"
fi

git clone $exercismRepo

#Temporary directory for files
mkdir temp

#This is used to determine the version of Ruby to install
wget https://github.com/exercism/exercism.io/raw/master/Gemfile
sudo pwd
sudo cp ~/ExercismDevSetup/GemFile ~/ExercismDevSetup/temp/Gemfile
sudo rm ~/ExercismDevSetup/Gemfile


rubyVersion=$(cat temp/Gemfile | grep "ruby '")
rubyVersion=${rubyVersion:6:5}

echo "GemFile Requires Ruby " + $rubyVersion
echo "Installing Ruby " + $rubyVersion

#Install Ruby Procedure
sudo apt-get install rbenv ruby-build -y
rbenv install $rubyVersion

#Install PostGreSQL
sudo apt-get install postgresql postgresql-contrib -y

#Install NodeJS
sudo apt-get install nodejs -y

#Execute the initial script provided by Exercism.io
chmod a+x exercism.io/bin/setup
source exercism.io/bin/setup
