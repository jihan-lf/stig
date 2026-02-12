source /tmp/lib.sh

if ! rpm -q xorg-x11-server-common >/dev/null 2>&1; then exit $PASS; fi
exit $FAIL
