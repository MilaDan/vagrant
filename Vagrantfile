# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define :artifactory do |config|
    config.vm.box = "geerlingguy/centos7"
    config.vm.provision :shell, path: "artifactory.sh"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.hostname = "artifactory"
    config.vm.network :forwarded_port, guest: 8081, host: 8081
    config.vm.provider :virtualbox do |vb|
      vb.memory = 256
      vb.customize ["modifyvm", :id, "--cpus", "8"]
      vb.customize ["modifyvm", :id, "--memory", "4096"]
    end
  end

# Vagrant.configure(2) do |config|
  config.vm.define :jenkins do |config|
    config.vm.box = "geerlingguy/centos7"
    config.vm.hostname = "jenkins"
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.provision :shell, path: "jenkins.sh"
    config.vm.provider :virtualbox do |vb|
      vb.memory = 256
    end
  end

# Vagrant.configure(2) do |config|
  config.vm.define :sonarqube do |config|
    config.vm.box = "geerlingguy/centos7"
    config.ssh.insert_key = false
    config.vm.hostname = "sonarqube"
    config.vm.network :forwarded_port, guest: 9000, host: 9000
    config.vm.provision :shell, path: "sonarqube.sh"
    config.vm.provider :virtualbox do |vb|
      vb.name = "sonarqube"
      vb.memory = 512
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
end 
