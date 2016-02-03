#!/bin/bash

/etc/init.d/rethinkdb restart
supervisord -c /subsystem/supervisord.conf
