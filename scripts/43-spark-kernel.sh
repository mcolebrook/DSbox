#!/usr/bin/env bash
#http://spark.apache.org/docs/latest/programming-guide.html

HOME=/home/vagrant
SPARK_KERNEL_HOME=/opt
SPARK_KERNEL_FILE=spark-kernel-0.1.5-SNAPSHOT.tar.gz
SCALA_KERNEL_PATH=$HOME/.local/share/jupyter/kernels/scala
TEMP_DIR=/tmp

#echo $HOME $SPARK_KERNEL_HOME $SPARK_KERNEL_FILE $SCALA_KERNEL_PATH $TEMP_DIR

# install spark-kernel
# https://github.com/ibm-et/spark-kernel/wiki/Getting-Started-with-the-Spark-Kernel
#cd $TEMP_DIR
#git clone https://github.com/ibm-et/spark-kernel.git 
#cd spark-kernel
#make build
#make dist

if [ -z "$SPARK_HOME" ]; then
  export SPARK_HOME=/opt/spark
fi

cd $SPARK_KERNEL_HOME
sudo cp /vagrant/apps/$SPARK_KERNEL_FILE .
sudo tar xzvf $SPARK_KERNEL_FILE
sudo chown -R root:root spark-kernel
sudo rm $SPARK_KERNEL_FILE

sudo -u vagrant mkdir -p $SCALA_KERNEL_PATH
#sudo -u vagrant cp /vagrant/apps/logo-64x64.png $SCALA_KERNEL_PATH
sudo -u vagrant ln -s $SPARK_KERNEL_HOME/spark-kernel/logo-64x64.png $SCALA_KERNEL_PATH/logo-64x64.png

#sudo -u vagrant sh -c 'cat > $SCALA_KERNEL_PATH/kernel.json <<EOF
#sudo -u vagrant sh -c 'cat > /home/vagrant/.local/share/jupyter/kernels/scala/kernel.json <<EOF
sudo su vagrant -c 'cat > /home/vagrant/.local/share/jupyter/kernels/scala/kernel.json <<EOF
{
  "resources_dir": "/home/vagrant/.local/share/jupyter/kernels/scala/",
  "display_name": "Scala 2.10 (Spark)",
  "language_info": { "name": "scala" },
  "argv": [
    "/opt/spark-kernel/bin/spark-kernel",
    "--profile",
    "{connection_file}"
  ],
  "codemirror_mode": "scala",
  "env": {
    "SPARK_OPTS": "--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=trace",
    "MAX_INTERPRETER_THREADS": "16",
    "SPARK_CONFIGURATION": "spark.cores.max=4",
    "CAPTURE_STANDARD_OUT": "true",
    "CAPTURE_STANDARD_ERR": "true",
    "SEND_EMPTY_OUTPUT": "false",
    "SPARK_HOME": "/opt/spark",
    "PYTHONPATH": "/opt/spark/python:/opt/spark/python/lib/py4j-0.8.2.1-src.zip"
 }
}
EOF'

