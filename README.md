# Data Science box (DSbox)
This is a Linux (Ubuntu) box deployed by vagrant including the following Data Science apps:
- [Spark] 1.5.2: one master node and up to 9 slaves. 
- [Jupyter] 4.0.6 (IPython 4.0.1): kernels for Python 2 & 3, R, and Scala 2.10. It also includes [RISE], [test_helper], and [IPython-extensions].
- [Python] 2 and 3.
- [R] version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree".
- [RStudio Server] v0.99.491.
- [Java JDK 7] (1.7.0_91).
- [Scala] 2.10.
- [Zeppelin] 0.5.5.
- [scikit-learn] 0.17: for Python 2 and 3.
- [TensorFlow] 0.6.0: for Python 2 and 3, but **ONLY for 64-bit systems**.

It has been succesfully tested on both `ubuntu/trusty32` and `ubuntu/trusty64` systems.

# Pre-deployment steps
To install the box, you must follow the next steps:

1. Install [VirtualBox]: if you use any other provider, you must change the `provider` parameter in the Vagrantfile.
2. Install [Vagrant].
3. Install [Git].
4. Clone this repository to a specific folder:
```sh 
$ git clone https://github.com/mcolebrook/dsbox.git <YOUR_BOX_FOLDER>
```

**Remark**: some Windows users told me that they got line-ending issues (see [GitHub Help]) after cloning and starting up the box. To  fix this problem, and **BEFORE CLONING** the box, just type:

`$ git config --global core.autocrlf input`

# Config parameters
Go to `<YOUR_BOX_FOLDER>`, and edit the `Vagrantfile` to change the parameters:

| Parameter  | Description | Default value |
|------------|-------------|:-------------:|
| *provider* | VM provider  | "virtualbox" |
| *boxMaster* | OS in master node | "ubuntu/trusty32" |
| *boxSlave* | OS in slave nodes | ubuntu/trusty32 |
| *masterRAM* | Master's RAM in MB | 3072 |
| *masterCPU* | Master's CPU cores | 2 |
| *masterName* | name of the master node used in `scripts/spark-env-sh` | "spark-master" |
| *masterIP* | private IP of master node | "10.20.30.100" |
| *slaves*| # of slaves | 2 (max 9) |
| *slaveRAM* | Slave's RAM in MB | 1024 |
| *slaveCPU* | Slave's CPU cores | 2 |
| *slaveName* | base name for slave nodes | "spark-slave" |
| *slavesIP* | base private IP for slave nodes | "10.20.30.10" |
| *IPythonPort* | IPython/Jupyter port to forward (set in Jupyter/IPython config file) | 8001 |
| *SparkMasterPort* | SPARK_MASTER_WEBUI_PORT | 8080 |
| *SparkWorkerPort* | SPARK_WORKER_WEBUI_PORT | 8081 |
| *SparkAppPort* | Spark app web UI port | 4040 |
| *RStudioPort* | RStudio server port | 8787 |
| *ZeppelinPort* | Zeppelin default port is 8080 -> conflict with Spark | 8888 |
| *SlidesPort* | `jupyter-nbconvert <file.ipynb> --to slides --post serve` | 8000 |

# Starting up and shutting down the cluster
You have several ways to start up the cluster.

## Deploy the master and all the slaves
To deploy the cluster with one master node and two slave nodes by default:
```sh 
$ vagrant up
```
Bear in mind that the whole process (bringing master+slaves up and the provisioning) may take **several minutes**!! On my Intel Core i7-4790 CPU (4 cores @ 3.60GHz) with 32 Gb RAM, I got the following times:

### Master
```sh
==> spark-master: END provisioning 2016/**/** **:**:**
==> spark-master: TOTAL TIME: 788 seconds
```

### Slaves
```sh
==> spark-slave-1: END provisioning 2016/**/** **:**:**
==> spark-slave-1: TOTAL TIME: 228 seconds
```

## Deploy only the master
In case you only want to deploy the master node:
```sh 
$ vagrant up spark-master
```

## Halt the cluster
To shutdown the whole cluster:
```sh
$ vagrant halt
```

## Halt only the master node
If you only want to halt the master node:
```sh
$ vagrant halt spark-master
```

## Delete the whole cluster (master + slaves)
In case you want to delete the whole cluster:
```sh
$ vagrant destroy
```

# Start/Stop Spark
To start up the Spark cluster (master + slaves):
```sh
$ vagrant ssh spark-master
...
$ $SPARK_HOME/sbin/start-all.sh
```
You can also start the cluster up from the host machine by typing:
```sh
$ vagrant ssh spark-master -c "bash /opt/spark/sbin/start-all.sh"
```
To halt the cluster, just run `stop-all.sh`.
Remember that you can access Spark info in the following ports:
- [Spark Master Web UI]
- [Spark Worker Web UI]
- [Spark App Web UI]

# Starting Jupyter
The best way to start the Jupyter notebook is the following:
```sh
$ vagrant ssh spark-master
...
$ cd /vagrant/jupyter-notebooks
$ jupyter-notebook
```
Inside the folder `jupyter-notebooks` you may find some sample notebooks.
Then, go to your favorite browser and type in [`localhost:8001`](http://localhost:8001).
Besides, you can also start the Jupyter notebook with `pyspark` as the default interpreter by using the script `scripts/start-pyspark-notebook.sh`.
Remember that inside the Jupyter notebook you can:
* Code your scripts in Python 2, Python 3, R, and Scala 2.10.
* Use [RISE], [test_helper], and [IPython-extensions].

To stop the notebook, just press the keys `Ctrl+C`.

# Starting RStudio
The RStudio Server daemon should be alreaday running in the background, so you only have to type in your browser [`localhost:8787`](http://localhost:8787). In order to work with Spark, you have to run the commands inside the `config.R` script. You may find helpful this [RStudio cheat sheet].

# Installing Zeppelin
I recommend you to build Zeppelin aside from the provision of the master node, since it takes a long time to complete the compilation.
Thus, you can run the following lines, and wait until all modules are built.
```sh
$ vagrant ssh spark-master
$ cd /vagrant/scripts
$ sudo ./60-zeppelin.sh
```
Once all the modules are compiled inside the `spark-master` node, you can start Zeppelin typing:
```sh
$ sudo env "PATH=$PATH" /opt/zeppelin/bin/zeppelin-daemon.sh start
```
Remeber to use the same command with 'stop' to halt the daemon.
Alternatively, you can run the script directly from the host machine by means of:
```sh
$ vagrant ssh spark-master -c "bash /opt/zeppelin/bin/zeppelin-daemon.sh start"
```
Finally, to start working with Zeppelin you may use the notebooks inside the folder `/vagrant/zeppelin_notebooks`.

# Installing `scikit-learn` and `tensorflow`
You may install these two libraries running the following lines:
```sh
$ vagrant ssh spark-master
$ cd /vagrant/scripts
$ sudo ./61-scikit-learn-tensorflow.sh
```

Remember that Tensor Flow is available for **64-bit systems** only.

# License
GNU. Please refer to the [LICENSE] file in this repository.

# Acknowledgements (in alphabetical order)
Thanks to the following people for sharing their projects: [Adobe Research], [Damián Avila], [Dan Koch], [Felix Cheung], [Francisco Javier Pulido], [Gustavo Arjones], [IBM Cloud Emerging Technologies], [Jee Vang], [Jeffrey Thompson], [José A. Dianes], [Maloy Manna], [NGUYEN Trong Khoa], and [Peng Cheng].

Thanks also to the following people for pointing me out some bugs: [Carlos Pérez-González], [Christos Iraklis Tsatsoulis].

[Adobe Research]: https://github.com/adobe-research
[Damián Avila]: https://github.com/damianavila
[Dan Koch]: http://github.com/dmkoch
[Felix Cheung]: http://github.com/felixcheung
[Francisco Javier Pulido]: http://www.franciscojavierpulido.com
[Gustavo Arjones]: http://github.com/arjones
[IBM Cloud Emerging Technologies]: https://github.com/ibm-et
[Jee Vang]: https://github.com/vangj
[Jeffrey Thompson]: https://github.com/jkthompson/pyspark-pictures
[José A. Dianes]: https://github.com/jadianes
[Maloy Manna]: https://github.com/dnafrance
[NGUYEN Trong Khoa]: http://www.trongkhoanguyen.com
[Peng Cheng]: http://github.com/tribbloid

[Carlos Pérez-González]: https://github.com/cpgonzal
[Christos Iraklis Tsatsoulis]: https://www.linkedin.com/in/christos-iraklis-tsatsoulis-165b1124

[Git]: https://git-scm.com/downloads
[GitHub Help]: https://help.github.com/articles/dealing-with-line-endings
[IPython-extensions]: https://github.com/ipython-contrib/IPython-extensions
[Java JDK 7]: http://openjdk.java.net/projects/jdk7
[Jupyter]: http://jupyter.org
[LICENSE]: https://github.com/mcolebrook/dsbox/blob/master/LICENSE
[Python]: https://www.python.org
[R]: https://cran.r-project.org
[RISE]: https://github.com/damianavila/RISE
[RStudio Server]: https://www.rstudio.com/products/RStudio/#Server
[RStudio cheat sheet]: http://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf
[Scala]: http://www.scala-lang.org
[scikit-learn]: http://scikit-learn.org/stable/
[Spark]: http://spark.apache.org
[Spark Master Web UI]: http://localhost:8080
[Spark Worker Web UI]: http://localhost:8081
[Spark App Web UI]: http://localhost:4040
[TensorFlow]: https://www.tensorflow.org/
[test_helper]: https://github.com/hpec/test_helper
[Vagrant]: https://www.vagrantup.com
[VirtualBox]: https://www.virtualbox.org
[Zeppelin]: https://github.com/apache/incubator-zeppelin
