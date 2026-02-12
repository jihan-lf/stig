source /tmp/lib.sh

if findmnt -kn /dev/shm >/dev/null 2>&1 && ! findmnt -kn /dev/shm | grep -v nodev | grep -q .; then exit $PASS; fi
exit $FAIL
