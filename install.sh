#!/bin/bash

# Installing `RethinkDB`
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | tee /etc/apt/sources.list.d/rethinkdb.list
apt-get install -y wget
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add -
apt-get update && apt-get install -y rethinkdb
cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
# Installing `PyPy + Py3K`
wget https://bitbucket.org/pypy/pypy/downloads/pypy3-2.4.0-linux64.tar.bz2
mkdir pypy && tar xvjf pypy3-2.4.0-linux64.tar.bz2 -C pypy --strip-components 1
rm pypy3-2.4.0-linux64.tar.bz2
# Installing `pip3` for the `PyPy + Py3K`
wget https://bootstrap.pypa.io/3.2/get-pip.py
./pypy/bin/pypy3 get-pip.py
rm get-pip.py
# Installing `pip3`'s packages
./pypy/bin/pip3 install --upgrade pip
./pypy/bin/pip3 install rethinkdb falcon gunicorn
# Installing `supervisor`
apt-get install -y python-pip
pip install --upgrade pip
pip install supervisor
