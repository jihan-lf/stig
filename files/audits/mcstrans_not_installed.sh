source /tmp/lib.sh

if ! rpm -q mcstrans &> /dev/null; then
  exit $FAIL
fi
exit $PASS