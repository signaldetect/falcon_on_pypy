#!/bin/bash

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | tee /etc/apt/sources.list.d/rethinkdb.list
apt-get install -y wget
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add -
apt-get update && apt-get install -y rethinkdb
cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
apt-get install -y python3-pip
pip3 install virtualenv
wget https://bitbucket.org/pypy/pypy/downloads/pypy3-2.4.0-linux64.tar.bz2
tar xvjf pypy3-2.4.0-linux64.tar.bz2
rm pypy3-2.4.0-linux64.tar.bz2
virtualenv -p pypy3-2.4.0-linux64/bin/pypy3 venv
source venv/bin/activate
pip install rethinkdb falcon gunicorn
deactivate
