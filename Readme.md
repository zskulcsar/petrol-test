## Test description

* [x] Create a hosted git repository account of your choice (if you do not already possess one) e.g. github, gitlab, bitbucket, etc.
* [x] Provide us with the account name
* [x] Create a public repository for this assessment and provide the name once complete
* Use the repository for the configuration and code that will:
   * [x] Spin up a Linux Vagrant box of your choice
   * [x] Configure Vagrant to use Ansible as the provisioner
   * [x] Configure the box with an IP address available to the hosting OS
   * Write playbook/playbooks to:
     * [x] Install and start docker
     * [x] Build a docker container based on the official Alpine Linux container (library/alpine:latest)
     * [x] Build the container so that nginx is installed and started
     * [x] Configure nginx to serve out some static “Hello World” content
     * [x] Start the container as a micro service

### Test Criteria:
   * At the end of the provisioning the URL to the web page should be available from the hosting OS
   * Write appropriate documentation in the repository to explain how someone cloning it should provision the Vagrant VM and access the web URL serving out the “Hello World”

### Notes:
* Commit as little or as often as you like
* For  extra points write some tests using the test framework of choice (serverspec, testinfra, etc) or even simple bash/python scripts to run tests of your choice to confirm/deny that the deployment has worked

## Requirements

* gnu make
* Python 2.7 with virtualenv
* Vagrant (v2.1.1) however an older version should work fine as well as not using any specific
* docker (v18.03.1)
* packer (v1.2.4)
* Virtualization software such as Virtualbox (v5.0.10) - though Vagrant should install this on first run (asks for root password as part of the installation process)

## Description

The solution uses [ansible](https://www.ansible.com/), [vagrant](https://www.vagrantup.com/), [packer](https://www.packer.io/) and [docker](https://www.docker.com/) to:
 * create a docker image (packer, docker, ansible) and export it as a tar file to be imported into the host
 * create a host VM (vagrant, ansible, docker) to run the image created in the previous step

## Usage

in the root of the project please run make. It should produce the following output:
```
zsoltk$ make
Run make -s <target> where <target> is:
  env           : create virtualenv in folder venv & install dependencies
  container     : create and export the container using packer (packer build)
  host          : provision the guest VM with vagrant & ansible (vagrant up)
  clean         : deletes the vagrant VM, the container image and the virtualenv
  build         : starts from clean and does all the previous steps
  test          : checks whether content is being served on port 8080
  host-down     : deletes the vagrant VM
```

Normally you should run `make build` but if you want you can run the steps one-by-one:
clean -> container -> host


### Rationale

The following design decisions were made:

#### Packer
 * although it would have been a simple yet "good enough" solution to use a plain Dockerfile for the container it is not the best option:
   * the dockerfile format is not the best for tasks other than the basics
   * extra steps are required to have the image exported otherwise a remote container repository needs to be handled
 * with packer we can use ansible local provisioner to configure the box. Originally ansible-container was made to run but it turned out that the project is dead. Hence a different solution was provided to provide continuity
 * 

#### Virtualenv
 * with virtualenv it is possible to keep all python installation in the scope of the project, ie.: don't litter
 * easy to handle dependencies and no sideffects, incompatibilities with other projects and with the preconfigured environment

#### Make
 * easy and yet simple to manage interface over bash scripts.
 * hides complexity from the end user

## Sidenote

Originally, I tried to make this work with [ansible-container](https://docs.ansible.com/ansible-container/) as it provides a better way of handling the installation steps than docker's Dockerfile. However ... with the latest docker the ansible-container build fails. After some investigation it turned out that the when the `--debug` flag is set the running code is actually different see: ![--debug](https://github.com/zskulcsar/petrol-test/blob/master/doc/debug_fail.png).

An issue was raised: (https://github.com/ansible/ansible-container/issues/937) along with a pull request (https://github.com/ansible/ansible-container/pull/938) for the ansible-container maintainers to accept.
