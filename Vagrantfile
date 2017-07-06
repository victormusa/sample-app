# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "debian/jessie64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

#first i will run the alarm check script so we know in our email exactly when server is up

system('sudo nohup ./alarmifdown.sh &')

# Here i start all configuration for the 3 vms
Vagrant.configure(2) do |config|
config.vm.synced_folder ".", "/vagrant", type: "rsync"
	config.vm.define :nginx do |nginx_config|
	nginx_config.vm.box = "debian/jessie64"
	nginx_config.vm.host_name = "nginx.devops.com"
	nginx_config.vm.network "private_network", ip:"10.127.0.10"
  	nginx_config.vm.provider :virtualbox do |vb|
        	vb.memory = 512
        	vb.cpus = 2
		end
	nginx_config.vm.provision "shell", path: "nginxinstall.sh", args: ENV['SHELL_ARGS']
	end
    config.vm.define :redis do |redis_config|
	redis_config.vm.box = "debian/jessie64"
 	redis_config.vm.host_name = "redis.devops.com"
	redis_config.vm.network "private_network", ip:"10.127.0.30"
	redis_config.vm.box_check_update = false
  	redis_config.vm.provider :virtualbox do |vb|
		vb.memory = 256
		vb.cpus = 1
		end
	redis_config.vm.provision :shell, :path => "redisinstall.sh"
	end
config.vm.define :php do |php_config|
    	php_config.vm.box = "debian/jessie64"
    	php_config.vm.host_name = "php.devops.com"
    	php_config.vm.network "private_network", ip:"10.127.0.20"
	php_config.vm.box_check_update = false
	php_config.vm.provider :virtualbox do |vb|
		vb.memory = 1024
        	vb.cpus = 1
		end
	php_config.vm.provision "shell", path: "php-fpminstall.sh", args: ENV['SHELL_ARGS']		
	end
end
