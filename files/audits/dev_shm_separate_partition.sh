source /tmp/lib.sh

if findmnt -kn /dev/shm >/dev/null 2>&1; then exit $PASS; fi
exit $FAIL
