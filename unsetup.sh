#!/usr/bin/bash
# This script does not undo everything setup.sh does, but enough 
# that you can run setup.sh again

if [ $USER != root ]; then
    echo Error: Run as root, e.g., "sudo bash unsetup.sh"
    exit 2
fi

SCRIPT_DIR="$( dirname -- "${BASH_SOURCE[0]}"; )"
SCRIPT_DIR=$(realpath $SCRIPT_DIR)
source $SCRIPT_DIR/setup.env

if [[ $DJANGO_USER ]]; then
    set -x
    userdel $DJANGO_USER
    rm -rf /home/$DJANGO_USER

    POSTGRES_VERSION=17
    sed --in-place=bak 's/^local\(.*\)all\(.*\)all\(.*\)md5/local\1all\2all\3peer/' /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf
    sed --in-place=bak 's/^local\(.*\)all\(.*\)postgres\(.*\)md5/local\1all\2postgres\3peer/' /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf
    service postgresql restart
    sudo -u postgres psql -c "DROP DATABASE $APP_NAME;"

    systemctl stop nginx
    rm -f /etc/nginx/sites-available/* /etc/nginx/sites-enabled/*
    rm -f /usr/bin/certbot
else
    echo Cannot determine DJANGO_USER
    exit 3
fi
