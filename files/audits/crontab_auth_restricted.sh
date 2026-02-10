source /tmp/lib.sh      

if [ "$(stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.allow)" == "Access: (640/-rw-r-----) Uid: ( 0/ root) Gid: ( 0/ root)" ]; then exit $PASS; fi
exit $FAIL

#NOTE: this config might not even be present on the system, but if it is, it should be protected.