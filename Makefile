PULP_PROPERTIES += pulp_chip_family
include $(PULP_SDK_HOME)/install/rules/pulp_properties.mk

pulp_chip_upper = $(shell echo $(pulp_chip_family) | tr [a-z] [A-Z])

rt:
	cat dox/pulp-rt/pulp-rt.dxy.in | sed s/@CHIP_CONFIG@/CONFIG_$(pulp_chip_upper)/ > dox/pulp-rt/pulp-rt.dxy && cd dox && make && mkdir -p $$PULP_SDK_HOME/doc/runtime/$(pulp_chip_family) && cp -r doc/runtime/html/* $$PULP_SDK_HOME/doc/runtime/$(pulp_chip_family)
	cd $$PULP_SDK_HOME/doc/runtime && rm -f default && ln -s $(pulp_chip_family) default

vp:
	cd 	top && rm -f index.rst
	cd 	top && ln -s vp_top.rst index.rst
	cd top && make html && mkdir -p $$PULP_SDK_HOME/doc/sdk && cp -r _build/html/* $$PULP_SDK_HOME/doc/sdk

all: rt
	cd 	top && rm -f index.rst
	cd 	top && ln -s sdk_top.rst index.rst
	cd top && make html && mkdir -p $$PULP_SDK_HOME/doc/sdk && cp -r _build/html/* $$PULP_SDK_HOME/doc/sdk

.PHONY: vp rt