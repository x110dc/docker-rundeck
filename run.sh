#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
set -o xtrace
set -o allexport

sed -i "s/MYHOST/$MYHOST/g" /etc/rundeck/rundeck-config.properties

sed -i "s/MAILFROM/$MAILFROM/g" /etc/rundeck/rundeck-config.properties
sed -i "s/RDPASS/$RDPASS/g" /etc/rundeck/realm.properties

# Change the Rundeck admin password
echo "grails.mail.default.from=$MAILFROM" >> /etc/rundeck/rundeck-config.properties

#echo -e "$RDPASS\n$RDPASS" | passwd
/etc/init.d/rundeckd start
