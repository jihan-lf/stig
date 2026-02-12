source /tmp/lib.sh

if findmnt -kn /var/log/audit >/dev/null 2>&1 && ! findmnt -kn /var/log/audit | grep -v nodev | grep -q .; then exit $PASS; fi
exit $FAIL
