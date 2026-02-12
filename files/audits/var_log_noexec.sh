source /tmp/lib.sh

if ! findmnt -kn /var/log | grep -v 'noexec' | grep -q .; then exit $PASS; fi
exit $FAIL
