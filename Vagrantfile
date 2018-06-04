Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "https.test"
  config.vm.network :private_network, type: "dhcp"
  # Ideally we shouldn't be using the vagrant default key
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 512
  end

  # Ansible provisioning for docker and other host config
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "provisioning/vagrant-host.yml"
    ansible.become = true
  end

  # Docker privisioning
  config.vm.provision "shell",
    inline: "docker run -d -p 80:80 -p 443:443 library/alpine:latest /bin/true"
end