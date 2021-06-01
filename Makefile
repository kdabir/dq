# Makefile for has
# https://github.com/kdabir/has
# Sadly, longopts like --verbose are not working on MacOS for cp, mkdir and rm


# PREFIX is an environment variable.
# Use default value if not set.
ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

test : has
	bats .hastest.bats

has :
	# ensure 'has' in repo
	git checkout --force -- has

# install 'has' in specified directory
install : has
	chmod 755 has && \
	mkdir -v -p $(DESTDIR)$(PREFIX)/bin && \
	cp -v has $(DESTDIR)$(PREFIX)/bin/has

# update: has
update : update-fetch has

update-fetch : update-force
	# update repo from upstream
	git fetch --verbose --force

update-force :
	# remove local repo 'has' to force update
	rm -f has

uninstall :
	rm -f $(DESTDIR)$(PREFIX)/bin/has

.PHONY: test install uninstall update

