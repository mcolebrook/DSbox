# -*- mode: ruby -*-
# vi: set ft=ruby :

# ------------------------- CONFIG PARAMS ----------------------------
provider = "virtualbox"       # VM provider
boxMaster = "ubuntu/trusty32" # system to be installed on master
boxSlave = "ubuntu/trusty32"  # system to be installed on slaves

#masterRAM = 4096              # RAM in MB
masterRAM = 3072              # RAM in MB
masterCPUs = 2                # CPU cores
masterName = "spark-master"   # name of the master node (used in scripts/spark-env-sh)
masterIP = "10.20.30.100"     # private IP of master node

slaves = 2                    # number of slaves 
#slaveRAM = 2048               # RAM in MB
slaveRAM = 1024               # RAM in MB
slaveCPUs = 2                 # CPU cores
slaveName = "spark-slave"     # names of the slave nodes with a number appended
slavesIP = "10.20.30.10"      # private IPs of slaves appending a number

IPythonPort = 8001            # IPython/Jupyter port to forward (set in IPython config)
SparkMasterPort = 8080        # SPARK_MASTER_WEBUI_PORT
SparkWorkerPort = 8081        # SPARK_WORKER_WEBUI_PORT
SparkAppPort = 4040           # Spark app web UI port
RStudioPort = 8787            # RStudio server port
ZeppelinPort = 8888           # Zeppelin (default is 8080, conflict with Spark)
SlidesPort = 8000             # jupyter-nbconvert <file.ipynb> --to slides --post serve
# -------------------------- END CONFIG PARAMS -----------------------



# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  #config.vm.box = box

# config master node 
  config.vm.define masterName do |master|
    master.vm.box = boxMaster
    master.vm.hostname = masterName

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    master.vm.provider provider do |vb|
      # Display the VirtualBox GUI when booting the machine
      # vb.gui = true

      vb.memory = masterRAM
      vb.cpus = masterCPUs 
      vb.name = master.vm.hostname.to_s
      #vb.customize ['modifyvm', :id, '--natnet1', '192.168.1.0']
    end

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # master.vm.box_check_update = false

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # master.vm.network "forwarded_port", guest: 80, host: 8080
 
    master.vm.network :forwarded_port, host: IPythonPort,     guest: IPythonPort
    master.vm.network :forwarded_port, host: SparkMasterPort, guest: SparkMasterPort
    master.vm.network :forwarded_port, host: SparkWorkerPort, guest: SparkWorkerPort
    master.vm.network :forwarded_port, host: SparkAppPort,    guest: SparkAppPort
    master.vm.network :forwarded_port, host: RStudioPort,     guest: RStudioPort
    master.vm.network :forwarded_port, host: SlidesPort,      guest: SlidesPort
    master.vm.network :forwarded_port, host: ZeppelinPort,    guest: ZeppelinPort

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    master.vm.network "private_network", ip: masterIP

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # master.vm.network "public_network"

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.

    # Point to the root folder
    master.vm.synced_folder ".", "/vagrant"

    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.
    #master.vm.provision "shell", inline: <<-SHELL
    #  echo "Hello from MASTER!!" 
    #  sudo apt-get update
    #SHELL

    master.vm.provision "shell" do |p|
      p.path = "scripts/box-provision.sh"
      p.args = "-t MASTER -n #{slaves} -a #{slavesIP} -m #{masterName} -s #{slaveName}"
    end

    master.vm.post_up_message = "Remember to read the README file in your home directory..."
  end

  # config each worker node (slaves)
  (1..slaves).each do |i|
    config.vm.define "#{slaveName}-#{i}" do |node|
      node.vm.box = boxSlave
      node.vm.hostname = "#{slaveName}-#{i}" 
      node.vm.network "private_network", ip: "#{slavesIP}#{i}"
      node.vm.synced_folder ".", "/vagrant"

      # Provider-specific configuration so you can fine-tune various
      # backing providers for Vagrant. These expose provider-specific options.
      node.vm.provider provider do |vb|
        # Display the VirtualBox GUI when booting the machine
        # vb.gui = true

        # Customize the amount of memory on the VM:
        vb.memory = slaveRAM
        vb.cpus = slaveCPUs 
        vb.name = node.vm.hostname.to_s
        #vb.customize ['modifyvm', :id, '--natnet1', '192.168.1.0']
      end

      #node.vm.provision "shell", inline: <<-SHELL
      #  echo "Hello from SLAVE-#{i}"
      #SHELL

      node.vm.provision "shell" do |p|
        p.path = "scripts/box-provision.sh"
        p.args = "-t SLAVE -n #{slaves} -a #{slavesIP} -m #{masterName} -s #{slaveName}"
      end
    end
  end
end
