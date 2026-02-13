source /tmp/lib.sh

if ! rpm -q ypbind &>/dev/null; then
  exit $PASS
fi
exit $FAIL