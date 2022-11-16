TOP := $(shell git rev-parse --show-toplevel)

include $(TOP)/terraform-common.mk
include $(TOP)/trvs.mk

WRITE_CONFIG_OPTS := --write-bastion --write-nat --env-tail $(ENV_TAIL)

.PHONY: default
default: hello

CONFIG_FILES := \
	config/bastion.env \
	config/gce-workers-$(ENV_SHORT).json \
	config/worker-com.env \
	config/worker-org.env \
	$(NATBZ2)

.PHONY: .config
.config: $(CONFIG_FILES) $(ENV_NAME).auto.tfvars

$(CONFIG_FILES): config/.written config/.gce-keys-written

.PHONY: import-net
import-net:
	$(TOP)/bin/gce-import-net \
		--env $(ENV_SHORT) \
		--index $(shell awk -F- '{ print $$NF }' <<<$(ENV_NAME)) \
		--project $(shell $(TOP)/bin/lookup-gce-project $(ENV_NAME)) \
		--terraform $(TERRAFORM)

.PHONY: export-net
export-net:
	$(TOP)/bin/gce-export-net --terraform $(TERRAFORM)
