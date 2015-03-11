FROM x110dc/base
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yq openssh-client openjdk-7-jre

# Add the install commands
ADD ./install.sh /

ADD ./run.sh /

# Change Rundeck admin password from default
ENV RDPASS RDPASS

ENV MYHOST MYHOST

# From address when sending email
ENV MAILFROM MAILFROM

# Download Rundeck
ADD http://download.rundeck.org/deb/rundeck-2.4.2-1-GA.deb /tmp/rundeck.deb

# Run the installation script
RUN /install.sh
RUN chown rundeck /tmp/rundeck

RUN sed -i "s|localhost|rundeck.peoplepattern.com|g" /etc/rundeck/framework.properties && \
    sed -i "s|framework.server.password = admin|framework.server.password = kTvHYpHFoT7GT9|g" /etc/rundeck/framework.properties

ADD http://github.com/rundeck-plugins/rundeck-ec2-nodes-plugin/releases/download/1.5/rundeck-ec2-nodes-plugin-1.5.jar  /var/lib/rundeck/libext/rundeck-ec2-nodes-plugin-1.5.jar

ENTRYPOINT /run.sh

VOLUME /var/lib/rundeck/data
VOLUME /var/lib/rundeck/var
VOLUME /var/lib/rundeck/logs
VOLUME /var/rundeck/projects

EXPOSE 4440 4443
