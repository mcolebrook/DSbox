# http://koaning.io/theme/notebooks/sparkr.pdf
#spark_link <- "spark://spark-master:7077"
spark_path <- "/opt/spark"
spark_lib_path <- paste0(spark_path, '/R/lib')
spark_bin_path <- paste0(spark_path, '/bin')
.libPaths(c(.libPaths(), spark_lib_path))

#Sys.setenv(SPARK_HOME = spark_path)
#Sys.setenv(PATH = paste(Sys.getenv(c('PATH')), spark_bin_path, sep=':'))

library(SparkR)
sc <- sparkR.init("local[2]", "SparkR", spark_path,
                  list(spark.executor.memory="1g"))
sqlContext <- sparkRSQL.init(sc) 

sparkR.stop()
