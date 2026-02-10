source /tmp/lib.sh      

# stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab
# expected: Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)

if [ -f /etc/crontab ]; then
    perms=$(stat -Lc '%a' /etc/crontab)
    uid=$(stat -Lc '%u' /etc/crontab)
    gid=$(stat -Lc '%g' /etc/crontab)
    
    if [ "$perms" = "600" ] && [ "$uid" = "0" ] && [ "$gid" = "0" ]; then
        exit $PASS
    else
        exit $FAIL
    fi
else
    exit $FAIL
fi