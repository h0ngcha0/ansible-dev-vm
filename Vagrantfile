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
  # meanjs port
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # jekyll port
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.vm.provider :virtualbox do |v|
    # OS X users seem to need this
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.memory = 8192 # 8G
    v.cpus = 2 # no. of cores
  end

  config.vm.provision :shell, :path => "provisioning/bootstrap.sh"
  config.vm.provision :shell do |shell|
    shell.path = "provisioning/local-bootstrap.sh"
    shell.args = ENV["USER"]
  end

  [ "provisioning/base_packages.yml",
    "provisioning/scala.yml",
    "provisioning/javascript.yml",
    "provisioning/tmux.yml",
    "provisioning/mongo.yml"
  ].each { |x|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = x
      ansible.raw_arguments = "-v"
    end
  }

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/user.yml"
    ansible.raw_arguments = "-v"
    ansible.extra_vars = { username: ENV["USER"] }
  end

  [ "provisioning/emacs.yml",
    "provisioning/zsh.yml",
  ].each { |x|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = x
      ansible.raw_arguments = "-v"
      ansible.extra_vars = { remote_user: ENV["USER"] }
    end
  }
end
