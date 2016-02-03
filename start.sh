#!/bin/bash

/etc/init.d/rethinkdb restart
./pypy/bin/gunicorn -b :8888 app:api
