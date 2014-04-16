FROM ubuntu:12.04
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y openssh-client
RUN apt-get install -y openjdk-6-jre
# I wish there were a PPA for a recent stable version
ADD http://download.rundeck.org/deb/rundeck-2.0.3-1-GA.deb /
RUN dpkg -i /rundeck-2.0.3-1-GA.deb
# this is ugly and should be fixed. I simply pulled the rundeckd file out of
# the above DEB and made a single change: to remove the '&' from the end of the
# 'nohup' line so the it wouldn't run in the background; there's probably a
# better way to do this
ADD rundeckd /etc/init.d/rundeckd
USER rundeck
CMD ["/etc/init.d/rundeckd", "start"]
EXPOSE 4440
