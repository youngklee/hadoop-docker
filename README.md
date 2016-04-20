Standalone Mode
===============

This Dockerfile is for building an Apache Hadoop image for standalone operation.

Build
-----

```
docker build -t younglee/hadoop .
```

Run
---

```
docker run -it -P younglee/hadoop bash
cd /usr/local/hadoop
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar grep input output 'Apache'
cat output/*
```

The expected output is

```
9 Apache
```

This example is from the Standalone Operation section of the Apache Hadoop documentation (https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/SingleCluster.html).

Pseudo-distributed Mode
=======================

Switch to the feature/pseudo-distributed branch.

Build
-----

```
docker build -t younglee/hadoop:pseudo-dist .
```

Run
---

```
docker run -it -P younglee/hadoop:pseudo-dist
cd /usr/local/hadoop
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/root
bin/hdfs dfs -put etc/hadoop input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar grep input output 'Apache'
bin/hdfs dfs -cat output/*
```

The expected output is

```
35 Apache
```
