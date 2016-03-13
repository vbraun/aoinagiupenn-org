REPO_ROOT:=$(shell git rev-parse --show-toplevel)


default: $(REPO_ROOT)/tools/local/bin/pelican $(REPO_ROOT)/tools/gems/bin/compass

$(REPO_ROOT)/tools/local/bin/pelican: $(REPO_ROOT)/tools/local/bin/pip
	$(REPO_ROOT)/tools/local/bin/pip install --upgrade \
	    pelican Markdown typogrify livereload

$(REPO_ROOT)/tools/local/bin/pip:  Makefile
	pyvenv $(REPO_ROOT)/tools/local
	$(REPO_ROOT)/tools/local/bin/pip install --upgrade pip

$(REPO_ROOT)/tools/gems/bin/compass:  Makefile
	GEM_HOME=$(REPO_ROOT)/tools/gems gem install compass

clean:
	rm -rf $(REPO_ROOT)/tools/local $(REPO_ROOT)/tools/gems


.PHONY: default clean
