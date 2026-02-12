source /tmp/lib.sh

if [ "$(stat -Lc '%u %g' /etc/passwd)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/passwd))) -le $((8#644)) ]; then exit $PASS; fi
exit $FAIL
