lazyzone:
	echo "run 'make install'"

install:
	cp lazyzone /usr/local/bin/lazyzone

deb: debian/lazyzone-0.1.0.deb
debian/lazyzone-0.1.0.deb: lazyzone debian/control
	tar -czf debian/data.tar.gz lazyzone --transform 's,^,usr/bin/,'
	tar -czf debian/control.tar.gz debian/control --transform 's,^debian/,,'
	echo 2.0 >debian/debian-binary
	ar -r $@ debian/debian-binary debian/control.tar.gz debian/data.tar.gz
