source /tmp/lib.sh

if grep -Pq -- '^\h*max_log_file_action\h*=\h*keep_logs\b' /etc/audit/auditd.conf; then
    exit $PASS
else
    exit $FAIL
fi
