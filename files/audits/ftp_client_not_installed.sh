source /tmp/lib.sh

if ! rpm -q ftp > /dev/null 2>&1; then
  exit $FAIL
fi
exit $PASS