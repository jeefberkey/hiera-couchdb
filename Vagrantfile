# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "blacklabelops/centos7"
  config.vm.hostname = "couchdb.ophq.net"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5984, host: 5984

  config.vm.provision "shell", inline: <<-SHELL
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
    sudo yum install -y vim htop mlocate wget git deltarpm tree epel-release
    sudo updatedb
    #sudo yum install -y autoconf autoconf-archive automake curl-devel erlang-asn1 erlang-erts erlang-eunit erlang-os_mon erlang-xmerl help2man js-devel libicu-devel libtool perl-Test-Harness
    #sudo yum install -y gcc-c++
    curl -sSL https://get.docker.com/ | sudo sh
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo docker run -d -p 5984:5984 --name couchdb klaemo/couchdb
  SHELL
end

