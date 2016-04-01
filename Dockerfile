FROM ubuntu:14.04

MAINTAINER Young Lee

RUN apt-get -y update --fix-missing
RUN apt-get install -y openjdk-7-jdk curl
RUN curl -s http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s hadoop-2.7.2 hadoop

ENV HADOOP_HOME /usr/local/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH $PATH:$HADOOP_HOME/bin
ENV HADOOP_CONF $HADOOP_HOME/etc/hadoop

RUN $HADOOP_HOME/bin/hadoop namenode -format

EXPOSE 9000 50010 50020 50070 50075 50090
EXPOSE 19888
EXPOSE 49707 22
