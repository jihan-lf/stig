source /tmp/lib.sh

if ! findmnt -kn /var/log | grep -v 'nosuid' | grep -q .; then exit $PASS; fi
exit $FAIL
