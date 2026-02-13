source /tmp/lib.sh

if ! rpm -q setroubleshoot &> /dev/null; then
  exit $PASS
fi
exit $FAIL