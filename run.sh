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

if [ -n "${LDAP_CONFIG_PATH+1}" ]; then
  sed -i "s,AUTH_LOGIN_CONFIG,$LDAP_CONFIG_PATH,g" /etc/rundeck/profile
  sed -i "s/LOGINMODULE_NAME/ldap/g" /etc/rundeck/profile
else
  sed -i "s,AUTH_LOGIN_CONFIG,/etc/rundeck/jaas-loginmodule.conf,g" /etc/rundeck/profile
  sed -i "s/LOGINMODULE_NAME/RDpropertyfilelogin/g" /etc/rundeck/profile
fi

/etc/init.d/rundeckd start
