FROM x110dc/base
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -yq openssh-client openjdk-7-jre

# Add rundeck to sudoers
ADD ./sudoers.d/rundeck /etc/sudoers.d/

# Add the install commands
ADD ./install.sh /

ADD ./run.sh /
RUN chmod +x /run.sh

# Change Rundeck admin password from default
ENV RDPASS RDPASS

# Change this to your hostname (used for generating URLs):
ENV MYHOST MYHOST

# From address when sending email:
ENV MAILFROM MAILFROM

# Download Rundeck
ADD http://download.rundeck.org/deb/rundeck-2.3.2-1-GA.deb /tmp/rundeck.deb

# Run the installation script
RUN /install.sh
RUN chown rundeck /tmp/rundeck

ENTRYPOINT /run.sh

EXPOSE 4440 22
