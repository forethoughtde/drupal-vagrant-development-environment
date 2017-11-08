# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    ENV['LC_ALL']="en_US.UTF-8"

    config.vm.box = "ubuntu/trusty64"

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
        v.customize ["modifyvm", :id, "--acpi", "off"]
    end

    config.vm.synced_folder ".", "/vagrant", nfs: false
    config.vm.synced_folder "web/sites", "/vagrant/web/sites", :owner=> "www-data", :group=>"www-data", :mount_options => ["dmode=755", "fmode=755"]

    config.vm.provision :shell, :inline => 'echo "cd /vagrant" >> /home/vagrant/.bashrc'

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
    end

    # config.vm.network :forwarded_port, host: 21321, guest: 80
    config.vm.network :forwarded_port, host: 22321, guest: 443
    config.vm.network :forwarded_port, host: 22322, guest: 3306
    config.vm.network :private_network, type: "dhcp"

end
