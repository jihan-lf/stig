source /tmp/lib.sh

if ! rpm -q bind >/dev/null 2>&1 || { rpm -q bind >/dev/null 2>&1 && ! systemctl is-enabled named.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active named.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
