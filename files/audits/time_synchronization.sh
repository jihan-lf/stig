source /tmp/lib.sh      

if rpm -q chrony &>/dev/null; then exit $PASS; fi
exit $FAIL