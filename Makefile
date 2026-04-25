help:
	@echo "\
Usage: \n\
	setup - perform make setup in subdirs \
"


setup:
	cd flatpak-setup && make setup
	cd dl-music && make setup
