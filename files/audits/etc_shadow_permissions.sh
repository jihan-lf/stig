source /tmp/lib.sh

if [ "$(stat -Lc '%u %g' /etc/shadow)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/shadow))) -eq $((8#0)) ]; then exit $PASS; fi
exit $FAIL
