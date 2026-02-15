source /tmp/lib.sh

if grep -Pq -- '^\h*disk_full_action\h*=\h*(halt|single)\b' /etc/audit/auditd.conf \
&& grep -Pq -- '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' /etc/audit/auditd.conf; then
    exit $PASS
else
    exit $FAIL
fi
