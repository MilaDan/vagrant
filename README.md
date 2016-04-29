# vagrant-vm-for-jenkins
Vagrantfile and Bash script that neatly installs the latest Jenkins

### Requirements: 

A working Vagrant installation https://www.vagrantup.com/downloads.html

# Instructions:

Clone this repo and run vagrant up ( this may differ slightly for Windows)

```sh
$ git clone https://github.com/riojack/vagrant-vm-for-jenkins.git
$ cd vagrant-vm-for-jenkins
$ vagrant up
```

Look for the output at the end of the vagrant up process that looks like this...

```sh
==> default: Browse to https://localhost:8100 and use this password for initial setup: a508f6a03b8c48e6ae1157fe7633bcb3
==> default: Setup complete!
```

Then browse to this site on your computer, enter in the password from the Vagrant output and begin Jenkins Setup

http://localhost:8100


### Cleanup
Stop and Start Vagrant VM

```sh
vagrant halt
vagrant resume
```

Destroy (Stops and Deletes Vagrant VM)

```sh
vagrant destroy
```


