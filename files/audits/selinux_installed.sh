source /tmp/lib.sh

if rpm -q libselinux &>/dev/null; then exit $PASS; fi
exit $FAIL
