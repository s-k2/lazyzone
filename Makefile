VERSION=`(git tag --points-at HEAD ; echo "0.0.0") | sed -E 's/^v//' | head -n1`

lazyzone:
	echo "run 'make install'"

install:
	cp lazyzone /usr/local/bin/lazyzone

.PHONY: deb
deb:
	mkdir -p debian
	tar -czf debian/data.tar.gz lazyzone --transform 's,^,usr/bin/,'
	echo "Package: lazyzone" > debian/control
	echo "Version: $(VERSION)" >> debian/control
	echo "Section: admin" >> debian/control
	echo "Priority: optional" >> debian/control
	echo "Architecture: all" >> debian/control
	echo "Installed-Size: 4" >> debian/control
	echo "Depends: mawk | gawk" >> debian/control
	echo "Maintainer: Stefan Klein <s-k2@caipora.net>" >> debian/control
	echo "Description: simplify writing forward and reverse dns zone-files" >> debian/control
	tar -czf debian/control.tar.gz debian/control --transform 's,^debian/,,'
	echo 2.0 > debian/debian-binary
	ar -r lazyzone-$(VERSION).deb debian/debian-binary debian/control.tar.gz debian/data.tar.gz
