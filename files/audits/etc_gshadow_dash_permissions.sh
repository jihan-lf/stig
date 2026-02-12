source /tmp/lib.sh

if [ "$(stat -Lc '%u %g' /etc/gshadow-)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/gshadow-))) -eq $((8#0)) ]; then exit $PASS; fi
exit $FAIL
