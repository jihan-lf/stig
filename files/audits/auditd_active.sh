source /tmp/lib.sh

if systemctl is-enabled auditd | grep -q '^enabled' \
&& systemctl is-active auditd | grep -q '^active'; then
    exit $PASS
else
    exit $FAIL
fi
