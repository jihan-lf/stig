source /tmp/lib.sh

if ( [ ! -e /etc/security/opasswd ] || ( [ "$(stat -Lc '%u %g' /etc/security/opasswd)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/security/opasswd))) -le $((8#600)) ] ) ) && ( [ ! -e /etc/security/opasswd.old ] || ( [ "$(stat -Lc '%u %g' /etc/security/opasswd.old)" = "0 0" ] && [ $((8#$(stat -Lc '%a' /etc/security/opasswd.old))) -le $((8#600)) ] ) ); then exit $PASS; fi
exit $FAIL
