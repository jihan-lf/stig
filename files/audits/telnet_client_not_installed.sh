source /tmp/lib.sh

if ! rpm -q telnet >/dev/null 2>&1; then
  exit $PASS
fi
exit $FAIL