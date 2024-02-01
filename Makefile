SHELL:=/bin/bash -e
.SILENT: setup-dependencies setup-act setup-jq setup-terraform
.PHONY:  setup-dependencies setup-act setup-jq setup-terraform
dep_act_version:=latest
dep_terraform_version:=1.7.2
dep_jq:=1.7.1
dep_os:=$(shell uname -s | tr '[:upper:]' '[:lower:]')
dep_arch:=$(shell uname -m | sed 's/x86_64/amd64/')

setup: setup-dependencies
setup-dependencies:
	mkdir -p .bin .bin/downloads
	$(MAKE) \
		--no-print-directory \
		-j 4 \
		setup-act \
		setup-jq \
		setup-terraform
setup-act:
	cd .bin/downloads && wget -qN https://github.com/nektos/act/releases/$(dep_act_version)/download/act_$(shell uname -s)_$(shell uname -m).tar.gz
	tar -xf .bin/downloads/act_*.tar.gz -C .bin act
	chmod +x .bin/act
	echo -n "Installed: Nektos/Act: "
	.bin/act --version
setup-jq:
	cd .bin/downloads && wget -qN https://github.com/jqlang/jq/releases/download/jq-$(dep_jq)/jq-$(dep_os)-$(dep_arch)
	cp .bin/downloads/jq-* .bin/jq
	chmod +x .bin/jq
	echo -n "Installed: jqlang/jq: "
	.bin/jq --version
setup-terraform:
	cd .bin/downloads && wget -qN https://releases.hashicorp.com/terraform/$(dep_terraform_version)/terraform_$(dep_terraform_version)_$(dep_os)_$(dep_arch).zip;
	unzip -qq -o .bin/downloads/terraform_*.zip -d .bin
	chmod +x .bin/terraform
	echo -n "Installed: Hashicorp/Terraform: "
	.bin/terraform --version | head -n 1

