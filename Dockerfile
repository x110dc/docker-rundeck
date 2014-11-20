FROM x110dc/base
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yq openssh-client openjdk-7-jre

# Add rundeck to sudoers
ADD ./sudoers.d/rundeck /etc/sudoers.d/

# Add the install commands
ADD ./install.sh /

ADD ./profile /

# Change Rundeck admin from default to CH4NGE_Me
ENV RDPASS RDPASS

# Change this to your hostname (used for generating URLs):
ENV MYHOST MYHOST

# From address when sending email:
ENV MAILFROM MAILFROM

# Run the installation script
RUN /install.sh
RUN chown rundeck /tmp/rundeck

# Start the services with supervisord
CMD ["/usr/bin/supervisord", "--nodaemon"]

EXPOSE 4440 22
