# Ubuntu 14.04 + Python3 + PyPy + Falcon + RethinkDB

# Pulls base image
FROM ubuntu:14.04

# Bundles sources
COPY . /subsystem

# Installs dependencies
RUN cd /subsystem; /bin/bash install.sh

EXPOSE 8080
CMD cd /subsystem; /bin/bash start.sh
