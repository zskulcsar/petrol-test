## Test description

* [] Create a hosted git repository account of your choice (if you do not already possess one) e.g. github, gitlab, bitbucket, etc.
* [] Provide us with the account name
* [] Create a public repository for this assessment and provide the name once complete
* Use the repository for the configuration and code that will:
   * Spin up a Linux Vagrant box of your choice
   * Configure Vagrant to use Ansible as the provisioner
   * Configure the box with an IP address available to the hosting OS
   * Write playbook/playbooks to:
     * Install and start docker
     * Build a docker container based on the official Alpine Linux container (library/alpine:latest)
     * Build the container so that nginx is installed and started
     * Configure nginx to serve out some static “Hello World” content
     * Start the container as a micro service

   * At the end of the provisioning the URL to the web page should be available from the hosting OS
   * Write appropriate documentation in the repository to explain how someone cloning it should provision the Vagrant VM and access the web URL serving out the “Hello World”

Notes:
* Commit as little or as often as you like
* For  extra points write some tests using the test framework of choice (serverspec, testinfra, etc) or even simple bash/python scripts to run tests of your choice to confirm/deny that the deployment has worked

## Requirements

* Vagrant (v2.1.1) however an older version should work fine as well as not using any specific
* Virtualization software such as Virtualbox - though Vagrant should install this on first run (asks for root password as part of the installation process)
* Ansible ()
* docker 