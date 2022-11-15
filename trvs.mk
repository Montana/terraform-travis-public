$(TRVS_INFRA_ENV_TFVARS):
	trvs generate-config -f json -o $@ terraform-config $(INFRA)_$(ENV_SHORT)

$(TRVS_ENV_NAME_TFVARS):
	trvs generate-config -f json -o $@ terraform-config $(subst -,_,$(ENV_NAME))
