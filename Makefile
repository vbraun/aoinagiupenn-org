REPO_ROOT:=$(shell git rev-parse --show-toplevel)
TOOL:=$(REPO_ROOT)/tools/run_tool

SSH_HOST=localhost
SSH_PORT=22
SSH_USER=vbraun
SSH_TARGET_DIR=/var/www

GITHUB_PAGES_BRANCH=gh-pages

ifndef PORT
    PORT:=5500
endif


help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make publish                        generate using production settings '
	@echo '   make devserver                      start/restart development server   '

html:
	$(TOOL) pelican -D
	cp $(REPO_ROOT)/extra/* output/

scss:
	cd theme && $(TOOL) compass compile scss/main.scss --sass-dir=scss --css-dir=static/css
	$(MAKE) html

clean:
	rm -rf output

serve:
	cd $(OUTPUTDIR) && $(TOOL) python3 -m pelican.server $(PORT)

devserver:
	$(TOOL) dev_server.py $(PORT)

publish:
	$(PELICAN) -s publishconf.py

ssh_upload: publish
	scp -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

github: publish
	ghp-import -m "Generate Pelican site" -b $(GITHUB_PAGES_BRANCH) $(OUTPUTDIR)
	git push origin $(GITHUB_PAGES_BRANCH)

.PHONY: html scss help clean serve devserver publish ssh_upload github
