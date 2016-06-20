COFFEE = ./node_modules/coffee-script/bin/coffee

usage:
	@echo ''
	@echo 'make compile: Compile sources'
	@echo ''

# --

# Compile Assets
.PHONY: compile
compile:
	rm -r ./lib
	@$(COFFEE) --no-header -cbo ./lib ./src
