source /tmp/lib.sh

if findmnt -kn /var/log >/dev/null 2>&1; then exit $PASS; fi
exit $FAIL
