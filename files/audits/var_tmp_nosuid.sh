source /tmp/lib.sh

if ! findmnt -kn /dev/shm | grep -v 'nosuid' | grep -q .; then exit $PASS; fi
exit $FAIL
