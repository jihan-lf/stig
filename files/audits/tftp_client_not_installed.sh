source /tmp/lib.sh

if ! rpm -q tftp &> /dev/null; then
  exit $PASS
fi
exit $FAIL