source /tmp/lib.sh

if ! findmnt -kn /var/log | grep -v 'nodev' | grep -q .; then exit $PASS; fi
exit $FAIL
