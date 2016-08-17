COFFEE = ./node_modules/coffee-script/bin/coffee

usage:
	@echo ''
	@echo 'make compile: Compile sources'
	@echo ''

# --

# Compile Assets
.PHONY: compile
compile:
	[ -d ./lib ] && rm -r ./lib || 0
	@$(COFFEE) --no-header -cbo ./lib ./src
