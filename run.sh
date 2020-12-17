#!/bin/bash

cd src && zip -r src.zip * && mv src.zip .. && cd -

# --master yarn ：运行到yarn集群，固定写法
# --deploy-mode cluster：AM运行到yarn中，如果改成client则需要确保本地目录有./Python/bin/python3
# --num-executors 1：一个executor容器
# --archives hdfs:///Python.zip#Python：从hdfs集群下载/Python.zip到executor工作目录，并解压到Python目录
# --py-files ./src.zip：项目python源代码，会解压到executor的某目录下并令PYTHONPATH指向该目录
# --conf spark.pyspark.python=./Python/bin/python3：指定使用自行上传的Python
spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 1 \
  --executor-memory 1G \
  --archives hdfs:///Python.zip#Python \
  --py-files ./src.zip \
  --conf spark.pyspark.python=./Python/bin/python3 \
  src/main.py
