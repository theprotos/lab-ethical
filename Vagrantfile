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

############### ROUTER ###############

    config.vm.define "router" do |router|
      router.vm.box = "centos/8"
      router.vm.hostname = "#{PROJECT}-router"
      router.vm.network "private_network",
        type: "static",
        ip: "192.168.100.10"
      router.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
        vb.customize ["setextradata", :id, "GUI/HidLedsSync", 0]
      end
      router.vm.synced_folder "scripts", "/vagrant", type: "rsync", create: "true"
      router.vm.provision "shell", run: "always", inline: <<-SHELL
        cd /vagrant
        ./router-bootstrap.sh
      SHELL
    end

############### KALI ###############
  config.vm.define "kali" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.hostname = "#{PROJECT}-kali"
    kali.vm.network "private_network",
          type: "static",
          ip: "192.168.100.100"
    #kali.vm.network "private_network",
    #  type: "static",
    #  ip: "192.168.100.100",
    #  virtualbox__intnet: "mynetwork"
    kali.ssh.insert_key = false
    kali.vm.provider :virtualbox do |vb|
      vb.gui = false
      #vb.name = HOSTNAME
      vb.memory = 1024
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
      vb.customize ["setextradata", :id, "GUI/HidLedsSync", 0]
    end
    kali.vm.synced_folder "scripts", "/vagrant", type: "rsync", create: "true"
    #config.vm.network "forwarded_port", guest: 80, host: 50080
    #config.vm.network "forwarded_port", guest: 8080, host: 58080
    #config.vm.network "forwarded_port", guest: 443, host: 50443
    kali.vm.provision "shell", run: "always", inline: <<-SHELL
      cd /vagrant
      ./kali-bootstrap.sh
      #./network.sh -m 00:11:22:33:44:55
    SHELL
    #  kali.vm.provision "ansible" do |ansible|
    #    ansible.compatibility_mode = "2.0"
    #    ansible.playbook = "provisioning/main.yml"
    #  end
  end

  ############### Centos ###############
    config.vm.define "centos" do |centos|
      centos.vm.box = "centos/8"
      centos.vm.hostname = "#{PROJECT}-centos"
      #centos.ssh.insert_key = false
      centos.vm.network "private_network",
        type: "static",
        ip: "192.168.100.102"
      centos.vm.provider :virtualbox do |vb|
        vb.gui = false
        #vb.name = "#{PROJECT}-centos"
        vb.memory = 1024
        vb.cpus = 1
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
        vb.customize ["setextradata", :id, "GUI/HidLedsSync", 0]
        #vb.customize ["modifyvm", :id, "--nic1", "none"]
      end
      centos.vm.synced_folder "scripts", "/vagrant", type: "rsync", create: "true"
      centos.vm.provision "shell", run: "always", inline: <<-SHELL
        cd /vagrant
        ./centos-bootstrap.sh
        #./network.sh -m 00:11:22:33:44:55
      SHELL
    end
############### WINDOWS ###############
  config.vm.define "win" do |win|
    win.vm.box = "win-10-1903-ent"
    win.vm.hostname = "#{PROJECT}-windows"
    #config.vm.guest = :windows
    win.vm.network "private_network",
      type: "static",
      ip: "192.168.100.101"
    win.vm.provider :virtualbox do |vb|
      vb.gui = true
      #vb.name = "#{PROJECT}-windows"
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--description", "#{DESCRIPTION}"]
      vb.customize ["setextradata", :id, "GUI/HidLedsSync", 0]
    end
    #win.vm.synced_folder "scripts", "/vagrant", type: "smb", create: "true"
    win.vm.provision "shell", run: "always", inline: <<-SHELL
      echo "  --> Disable eth0"
      netsh interface set interface "Ethernet" disable
      echo "  --> Setup eth1"
      netsh interface ipv4 set address name="Ethernet 2" static 192.168.100.101 255.255.255.0 192.168.100.10
      netsh interface ip set dns "Ethernet 2" static 1.1.1.1
      #IPv4
      netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
      #IPv6
      netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:8,any" dir=in action=allow
    SHELL
  end

end

