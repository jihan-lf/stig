source /tmp/lib.sh

if findmnt -kn /home >/dev/null 2>&1 && ! findmnt -kn /home | grep -v nodev | grep -q .; then exit $PASS; fi
exit $FAIL
