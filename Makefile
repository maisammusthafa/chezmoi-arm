SHELL := /bin/bash

pkgname := chezmoi
target_os := 'raspbian'

.PHONY: install

install:
	@OS="$$(sed -n 's/^ID=//p' /etc/*release)"; \
	if [ "$$OS" == $(target_os) ]; then \
		bash ./prepare; \
		echo; \
		dpkg-deb --build $(pkgname); \
		sudo dpkg -i $(pkgname).deb; \
		rm -f $(pkgname).deb; \
	else \
		echo error: required target os is \'$(target_os)\'; \
	fi
