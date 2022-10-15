# -*- mode: ruby -*-
# vi: set ft=ruby  :

#########################################################################################################
#													#
# 	This Vagrantfile make an hybrid lab on virtualbox with Linux, Mac and Windows Machines		#
#													#
# 	Default Configuration requires 13GB of free RAM							#
# 	4GB of RAM its the minimal for Windows and MacOSx 						#
# 	Increase or decrease RAM configuration for any machine if necessary				#
#	Dont forget to create the entries on hosts files 						#
#		Linux   -> /etc/hosts 									#
#		Windows -> C:\Windows\system32\drivers\etc\hosts					#
#													#
#		192.168.56.50	master01						#
#		192.168.56.51	master02						#
#		192.168.56.52	master03						#
#		192.168.56.53	worker01						#
#		192.168.56.54	worker02						#
#		192.168.56.55	worker03						#
#		192.168.56.56	ansible						  #
#   192.168.56.49 loadbalancer        #
#													#
#########################################################################################################


machines = {
  "master01"   => {"memory" => "2048", "cpu" => "2", "ip" => "101", "image" => "ubuntu/bionic64"},
  "master02"   => {"memory" => "2048", "cpu" => "2", "ip" => "102", "image" => "ubuntu/bionic64"},
  "master03"   => {"memory" => "2048", "cpu" => "2", "ip" => "103", "image" => "ubuntu/bionic64"},
  "worker01"   => {"memory" => "2048", "cpu" => "2", "ip" => "104", "image" => "ubuntu/bionic64"},
  "worker02"   => {"memory" => "2048", "cpu" => "2", "ip" => "105", "image" => "ubuntu/bionic64"},
  "worker03"   => {"memory" => "2048", "cpu" => "2", "ip" => "106", "image" => "ubuntu/bionic64"},
  "ansible"   => {"memory" => "2048", "cpu" => "2", "ip" => "56", "image" => "ubuntu/bionic64"},
}

Vagrant.configure("2") do |config|

  # Will not check for box updates during every startup.
  config.vm.box_check_update = false

  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "192.168.56.#{conf["ip"]}"
      machine.vm.network "public_network", ip: "10.1.0.#{conf["ip"]}", bridge: "eth0"
      # machine.vm.provision "shell", path: "boot.sh"
      # machine.vm.provision "file", source: "key_gen.sh", destination: "/home/vagrant/"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/iac"]
      end
    end
  end

  config.vm.provider "virtualbox" do |rs|
    rs.memory = 2048
    rs.cpus = 2
    # rs.customize ["modifyvm", :id, "--groups", "/tools"]
  end


  # Master node where ansible will be installed
  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/bionic64"
    ansible.vm.hostname = "ansible"
    ansible.vm.network "private_network", ip: "192.168.56.110"
    ansible.vm.network "public_network", ip: "10.1.0.110", bridge: "eth0"
    # ansible.vm.provision "shell", path: "bootansible.sh"
    ansible.vm.provision "file", source: "key_gen.sh", destination: "/home/vagrant/"
  end

  #load balancer
  config.vm.define "loadbalancer" do |loadbalancer|
    loadbalancer.vm.box = 'ubuntu/bionic64'
    loadbalancer.vm.hostname = "loadbalancer"
    loadbalancer.vm.network :private_network, ip: "192.168.56.111"
    # config.vm.network "public_network", bridge: "Intel PRO/1000 MT Desktop (82540EM)"
    loadbalancer.vm.network "public_network", ip: "10.1.0.111", bridge: "eth0"
    # loadbalancer.vm.provision "shell", path: "loadb.sh"
    loadbalancer.vm.network "forwarded_port", guest: 8404, host: 8404
    # loadbalancer.vm.network "forwarded_port", guest: 6443, host: 6443
  end

    #rancher
    config.vm.define "rancher" do |rancher|
      rancher.vm.box = 'ubuntu/bionic64'
      rancher.vm.hostname = "rancher"
      rancher.vm.network :private_network, ip: "192.168.56.112"
      # config.vm.network "public_network", bridge: "Intel PRO/1000 MT Desktop (82540EM)"
      rancher.vm.network "public_network", ip: "10.1.0.112", bridge: "eth0"
      # etcd.vm.provision "shell", path: "boot.sh"
      # rancher.vm.network "forwarded_port", guest: 443, host: 8443
      # rancher.vm.network "forwarded_port", guest: 8080, host: 8080
      # rancher.vm.network "forwarded_port", guest: 80, host: 9090
      # etcd.vm.network "forwarded_port", guest: 443, host: 443
    end  

end