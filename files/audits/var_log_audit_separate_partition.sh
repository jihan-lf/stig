source /tmp/lib.sh

if findmnt -kn /var/log/audit >/dev/null 2>&1; then exit $PASS; fi
exit $FAIL
