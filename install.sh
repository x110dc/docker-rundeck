#!/bin/bash

dpkg -i /tmp/rundeck.deb
rm -f /tmp/rundeck.deb
chown -R rundeck /etc/rundeck
chmod 4755 /usr/bin/sudo	# no suid bit was set for sudo!?

# Modify init script to force it to run in the foreground (more
# Docker-friendly)
sed -i 's/&>>\/var\/log\/rundeck\/service.log &$//g' /etc/init.d/rundeckd

## remove the grails.serverURL so that absolute URLs aren't generated
# (this is needed for things like sending email:)
#sed -i '/grails.serverURL/d' /etc/rundeck/rundeck-config.properties

sed -i "s/^admin:admin/admin:$RDPASS/g" /etc/rundeck/realm.properties
sed -i "s/localhost:4440/$MYHOST:4440/g" /etc/rundeck/rundeck-config.properties

sed -i "s,/etc/rundeck/jaas-loginmodule.conf,AUTH_LOGIN_CONFIG,g" /etc/rundeck/profile
sed -i "s/RDpropertyfilelogin/LOGINMODULE_NAME/g" /etc/rundeck/profile

# Generate a new passwordless SSH key
#mkdir -p /var/lib/rundeck/.ssh/
#chown rundeck:rundeck /var/lib/rundeck/.ssh
#ssh-keygen -t rsa -f /var/lib/rundeck/.ssh/id_rsa -N ''

# Reset rundeck system user password and allow root to log on with ssh
#echo -e "$RDPASS\n$RDPASS" | passwd
#sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
#sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd	# https://github.com/dotcloud/docker/issues/5663

# do these things at runtime:
#cat /profile >> /etc/rundeck/profile
