source /tmp/lib.sh

if findmnt -kn /var >/dev/null 2>&1 && ! findmnt -kn /var | grep -v nosuid | grep -q .; then exit $PASS; fi
exit $FAIL
