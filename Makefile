setup: ## setup every command
	cd flatpak-setup && make setup
	cd dl-music && make setup
	cd makefile-autodoc && make setup


.DEFAULT_GOAL := help
.PHONY: help
help: ## Lists this, the help information, make sure to use # like on the rule like here
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
