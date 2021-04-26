# -*- mode: ruby -*-
# vi: set ft=ruby :

# vagrant rsync-auto


VAGRANTFILE_API_VERSION = "2"
PROJECT = "ethical"
DESCRIPTION = "#{PROJECT} lab environment"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "kalilinux/rolling"
  config.vm.hostname = "#{PROJECT}-kali"

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    #vb.name = HOSTNAME
    vb.memory = 1024
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
  end

  config.vm.synced_folder ".", "/vagrant", type: "rsync", create: "true"
  #config.vm.network "forwarded_port", guest: 80, host: 50080
  #config.vm.network "forwarded_port", guest: 8080, host: 58080
  #config.vm.network "forwarded_port", guest: 443, host: 50443

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update -qy
    apt-get install terminator -qy
  SHELL

#  config.vm.provision "ansible" do |ansible|
#    ansible.compatibility_mode = "2.0"
#    ansible.playbook = "provisioning/main.yml"
#  end

end

#Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.box = "win-10-1903-ent"
#  config.vm.network "private_network", ip: "192.168.100.100"
#end
