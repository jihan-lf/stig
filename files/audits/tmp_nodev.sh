source /tmp/lib.sh

if findmnt -kn /tmp >/dev/null 2>&1 && ! findmnt -kn /tmp | grep -v nodev | grep -q .; then exit $PASS; fi
exit $FAIL
