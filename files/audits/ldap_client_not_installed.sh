source /tmp/lib.sh

if ! rpm -q openldap-clients &>/dev/null; then
  exit $PASS
fi
exit $FAIL