# -*- mode: ruby -*-
# vi: set ft=ruby :

# vagrant rsync-auto


VAGRANTFILE_API_VERSION = "2"
PROJECT = "ethical"
DESCRIPTION = "#{PROJECT} lab environment"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

if Vagrant.has_plugin?("vagrant-vbguest")
  config.vbguest.auto_update = false
end

############### KALI ###############

  config.vm.define "kali" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.network "private_network",
      type: "static",
      ip: "192.168.100.100",
      virtualbox__intnet: "mynetwork"
    #kali.vm.network :public_network
    kali.vm.hostname = "#{PROJECT}-kali"

    kali.vm.provider :virtualbox do |vb|
      vb.gui = true
      #vb.name = HOSTNAME
      vb.memory = 1024
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
    end

    kali.vm.synced_folder "scripts", "/vagrant", type: "rsync", create: "true"
    #config.vm.network "forwarded_port", guest: 80, host: 50080
    #config.vm.network "forwarded_port", guest: 8080, host: 58080
    #config.vm.network "forwarded_port", guest: 443, host: 50443

    kali.vm.provision "shell", inline: <<-SHELL
      apt-get update -qqy
      apt-get install terminator -qqy
      #route add default gw 192.168.0.1
      #route add -net 192.168.100.0 netmask 255.255.255.0 gw 192.168.100.1
      cd /vagrant
      #./network.sh -m 00:11:22:33:44:55
    SHELL

    #  kali.vm.provision "ansible" do |ansible|
    #    ansible.compatibility_mode = "2.0"
    #    ansible.playbook = "provisioning/main.yml"
    #  end

  end

############### WINDOWS ###############

  config.vm.define "win" do |win|
    win.vm.box = "win-10-1903-ent"
    win.vm.hostname = "#{PROJECT}-windows"
    win.vm.network "private_network",
      type: "static",
      ip: "192.168.100.102",
      virtualbox__intnet: "mynetwork",
      auto_config: false
    win.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.name = "#{PROJECT}-windows"
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
    end
    #win.vm.synced_folder "scripts", "/vagrant", type: "smb", create: "true"
    win.vm.provision "shell", inline: <<-SHELL
      ls C:\\
      Get-NetAdapter
      echo 1 > C:\\test.txt
    SHELL
  end
end

