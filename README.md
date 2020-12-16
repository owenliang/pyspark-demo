# 开始使用pyspark

## 整体流程

```
1，利用miniconda生成python环境，并pip安装项目依赖
2，将上述python环境的目录打成zip包，上传到HDFS存放
3，编写pyspark程序，然后将源码打zip包
4，使用spark-submit，通过--archives指定从hadoop下载python环境到executor，通过spark.pyspark.python配置spark使用该python环境
5，使用spark-submit，传入pyspark主入口.py文件，同时将源码zip包通过--py-files传到executor，自动加入到PYTHONPATH
```

## 为什么要这样做？

```
不同pyspark项目的python环境可以隔离，非常重要。
```

## 如何打包python环境？

```
任找一台服务器，
1，创建名为tf的python3.8环境
conda create -n tf python=3.8
2，切换到该python环境
conda activate tf
3，安装项目pip依赖
pip install -r ./requirements.txt
4，找到python目录
which python
/root/anaconda3/envs/tf/bin/python
5，将该python目录打包zip
cd /root/anaconda3/envs/tf
zip -r Python.zip *
6，将Python.zip传到HDFS某目录下用作分发
hdfs dfs -put Python.zip /
```

miniconda创建的python环境完全独立（包括.so依赖），可以任意移动路径或者机器。

## 如何打包python代码？

```
1，将源码都放到src子目录内进行开发
2，进入src目录内，zip -r src.zip *将源码打包起来
3，spark-submit时--py-files上传本地src.zip加入到executor的PYTHONPATH中
4，spark-submit时指定程序入口为src/main.py
```

main.py在import引入时将根据PYTHONPATH成功找到所有包和模块，和本地开发体验一致。