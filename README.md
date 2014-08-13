## Summary

With this vagrant you can create a virtual machine with all that is
needed for Erlang, Scala and Javascript development using Emacs.

## Install

### Setup ssh access

The virtual environment will authenticate use ssh-agent forwarding to your host
machine.

    ssh-add <my-super-secret-key>

You can verify the keys are loaded with

    ssh-add -l

Once this is done, the virtual machine will not require the private keys, so you
don't need to copy them around.

### External repositories

#### Ubuntu 14.04

Install the latest Vagrant and VirtualBox. At the moment of writing this they
were: Vagrant 1.5.1 and Virtualbox 4.3.10

Install the latest version of Ansible as well.

For ubuntu:

    cd /tmp
    wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.1_x86_64.deb
    sudo dpkg -i vagrant_1.5.1_x86_64.deb
    wget http://download.virtualbox.org/virtualbox/4.3.10/virtualbox-4.3_4.3.10-92957~Ubuntu~precise_amd64.deb
    sudo dpkg -i virtualbox-4.3_4.3.10-92957~Ubuntu~precise_amd64.deb
    
    sudo apt-get install apt-add-repository
    sudo apt-add-repository ppa:rquillo/ansible
    sudo apt-get update
    sudo apt-get install ansible

### Workaround to make ansible ssh work

Create the entry in ~/.ssh/config so that ansible can connect to vm

    Host 127.0.0.1
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null


### Create and use the Vagrant environment

Create the virtual machine

    vagrant up

This can take quite some time the first time you run it as the virtual
environment needs to be provisioned.

Now that the machine is running you can ssh into it

    vagrant ssh

If you want to stop the virtual machine (to release memory, for example) run

    vagrant suspend

You can restart it again with `vagrant up` without reprovisioning it, if you
want to get rid of the virtual environment altogether run

    vagrant destroy

The next time you run `vagrant up` it will generate a new environment from
scratch.
