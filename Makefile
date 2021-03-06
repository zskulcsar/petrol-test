SHELL := /bin/bash
ENV_DIR := venv

help:
	@echo "Run make -s <target> where <target> is:"
	@echo "  env           : create virtualenv in folder $(ENV_DIR) & install dependencies"
	@echo "  container     : create and export the container using packer (packer build)"
	@echo "  host          : provision the guest VM with vagrant & ansible (vagrant up)"
	@echo "  clean         : deletes the vagrant VM, the container image and the virtualenv"
	@echo "  build         : starts from clean and does all the previous steps"
	@echo "  test          : checks whether content is being served on port 8080"
	@echo "  host-down     : deletes the vagrant VM"

# Configures the virtual environment
# Due to bug https://github.com/ansible/ansible-container/issues/919 pip needs to be forced to 9.0.3
env:
	virtualenv $(ENV_DIR)
	source $(ENV_DIR)/bin/activate && \
	$(ENV_DIR)/bin/pip install -Ur requirements.txt

.PHONY: clean
clean:
	@echo "Cleaning up"
	cd host && vagrant destroy -f
	rm -fr $(ENV_DIR)
	rm -f container/build/*

.PHONY: container
container:
	@echo "Creating nginx container"
	cd container && \
	packer build packer.nginx.json

.PHONY: host
host:
	@echo "Starting vagrant box"
	source $(ENV_DIR)/bin/activate && \
	cd host && \
	vagrant up

.PHONY: host-down
host-down:
	@echo "Destroying vagrant box"
	source $(ENV_DIR)/bin/activate && \
	cd host && \
	vagrant destroy -f

.PHONY: test
test:
	@echo "Checking for service"
	./test.sh

.PHONY: build
build: clean env container host