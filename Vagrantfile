# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "base"
  config.vm.provision :shell, :path => "script.sh"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  # artifactory 
  config.vm.network :forwarded_port, guest: 8081, host: 8081
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "8"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provision "shell", path: "./bootstrap.sh"
end

Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/ubuntu1404"
  config.ssh.insert_key = false
  config.vm.provider :virtualbox do |v|
    v.name = "sonarqube"
    v.memory = 512
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.hostname = "sonarqube"
  config.vm.network :forwarded_port, guest: 9000, host: 9000

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define :sonarqube do |sonarqube|
  end
end
