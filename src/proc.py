# -*- coding: utf-8 -*-

def generate_rdd(sess):
    # 本地列表转RDD
    rdd = sess.sparkContext.parallelize(['a', 'b', 'c'])
    # 保存RDD到HDFS目录
    rdd.saveAsTextFile('/prepare_data/')