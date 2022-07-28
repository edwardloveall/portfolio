# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.ssh.forward_agent = true
  config.vm.network "forwarded_port", guest: 80, host: 3000
end
