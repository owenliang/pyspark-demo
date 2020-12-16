# -*- coding: utf-8 -*-

from pyspark.sql import SparkSession
from proc import generate_rdd

sess = SparkSession.builder.appName('prepare_data').getOrCreate()
generate_rdd(sess)