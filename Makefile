SHELL := /bin/bash

pkgname := chezmoi
target := 'helios-raspbian'

.PHONY: install

install:
	@MACHINE="$$(hostname)-$$(sed -n 's/^ID=//p' /etc/*release)"; \
	if [ "$$MACHINE" == $(target) ]; then \
		bash ./prepare; \
		dpkg-deb --build $(pkgname); \
		sudo dpkg -i $(pkgname).deb; \
		rm -f $(pkgname).deb; \
	else \
		echo error: required target machine is \'$(target)\'; \
	fi
