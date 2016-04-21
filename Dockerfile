FROM ubuntu:14.04

MAINTAINER Young Lee

RUN apt-get -y update --fix-missing
RUN apt-get install -y openjdk-7-jdk curl openssh-server openssh-client
RUN curl -s http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s hadoop-2.7.2 hadoop

RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

ADD ssh_config /etc/ssh/ssh_config

ENV HADOOP_PREFIX /usr/local/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH $PATH:$HADOOP_PREFIX/bin
ENV HADOOP_CONF $HADOOP_PREFIX/etc/hadoop

RUN echo "export JAVA_HOME=$JAVA_HOME" >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

ADD core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
ADD hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

RUN $HADOOP_PREFIX/bin/hadoop namenode -format

EXPOSE 8020 9000 50010 50020 50100
EXPOSE 50070 50075 50090 50105
EXPOSE 22

ADD bootstrap.sh /etc/bootstrap.sh
CMD /etc/bootstrap.sh
