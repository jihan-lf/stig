source /tmp/lib.sh

if ! findmnt -kn /dev/shm | grep -v 'noexec' | grep -q .; then exit $PASS; fi
exit $FAIL
