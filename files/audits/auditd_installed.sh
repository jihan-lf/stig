source /tmp/lib.sh

if rpm -q audit audit-libs | grep -q "not installed"; then
    exit $FAIL
else
    exit $PASS
fi
