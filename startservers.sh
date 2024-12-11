#!/usr/bin/bash
# Run this script as $DJANGO_USER
# Whereas setup.sh only needs to be run once ever, this needs to be run on every boot

set -e
SCRIPT_DIR="$( dirname -- "${BASH_SOURCE[0]}"; )"
source $SCRIPT_DIR/setup.env

if [ $USER != $DJANGO_USER ]; then
    echo Error: Run this script as user $DJANGO_USER
else
    echo $DJANGO_USER_PASSWORD | sudo -S service postgresql restart
    sudo systemctl restart nginx
    cd ~/django/$APP_NAME
    echo Launching site at https://$SERVER_NAME
    gunicorn --bind 0.0.0.0:8000 config.wsgi
fi


