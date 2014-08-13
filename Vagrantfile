# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/20140625/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  system 'mkdir', '-p', 'Development'
  config.vm.synced_folder "Development/", "/home/vagrant/Development/"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.network "private_network", ip: "192.168.2.3"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  # couchdb
  config.vm.network "forwarded_port", guest: 5984, host: 5984

  # sca
  config.vm.network "forwarded_port", guest: 8181, host: 8181
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # apollo
  config.vm.network "forwarded_port", guest: 61613, host: 61613
  config.vm.network "forwarded_port", guest: 61680, host: 61680

  config.vm.provider :virtualbox do |v|
    # OS X users seem to need this
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.memory = 8192
    v.cpus = 2
  end

  config.vm.provision :shell, :path => "provisioning/bootstrap.sh"
  config.vm.provision :shell do |shell|
    shell.path = "provisioning/local-bootstrap.sh"
    shell.args = ENV["USER"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/base_packages.yml"
    ansible.raw_arguments = "-v"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/user.yml"
    ansible.raw_arguments = "-v"
    ansible.extra_vars = { username: ENV["USER"] }
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/emacs.yml"
    ansible.raw_arguments = "-v"
    ansible.extra_vars = { remote_user: ENV["USER"] }
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/zsh.yml"
    ansible.raw_arguments = "-v"
    ansible.extra_vars = { remote_user: ENV["USER"] }
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/scala.yml"
    ansible.raw_arguments = "-v"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/javascript.yml"
    ansible.raw_arguments = "-v"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/mongo.yml"
    ansible.raw_arguments = "-v"
  end

end
