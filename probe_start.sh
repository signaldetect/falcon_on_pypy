#!/bin/bash

/etc/init.d/rethinkdb restart
source venv/bin/activate
gunicorn -b :8888 app:api
