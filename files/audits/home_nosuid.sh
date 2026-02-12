source /tmp/lib.sh

if findmnt -kn /home >/dev/null 2>&1 && ! findmnt -kn /home | grep -v nosuid | grep -q .; then exit $PASS; fi
exit $FAIL
