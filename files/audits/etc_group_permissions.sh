source /tmp/lib.sh

if [ "$(stat -Lc '%u %g' /etc/group)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/group))) -le $((8#644)) ]; then exit $PASS; fi
exit $FAIL
