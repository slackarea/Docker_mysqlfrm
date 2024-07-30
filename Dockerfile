FROM ubuntu:12.04
LABEL org.opencontainers.image.authors="expert@slackarea.net"

RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ precise main" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes perl-base=5.14.2-6ubuntu2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes python-minimal=2.7.3-0ubuntu2 python2.7-minimal=2.7.3-0ubuntu3 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget mysql-server
RUN apt-get install -y python

WORKDIR /app
COPY mysql-connector-python_1.1.4-1ubuntu12.04_all.deb . 
COPY mysql-utilities_1.3.6-1ubuntu12.04_all.deb .

RUN dpkg -i mysql-connector-python_1.1.4-1ubuntu12.04_all.deb
RUN dpkg -i mysql-utilities_1.3.6-1ubuntu12.04_all.deb

ADD init.sql /tmp/
RUN (/usr/bin/mysqld_safe &); sleep 3; mysql -u root < /tmp/init.sql

CMD ["/usr/bin/mysqld_safe"]

