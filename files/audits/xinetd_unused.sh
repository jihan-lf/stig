source /tmp/lib.sh

if ! rpm -q xinetd >/dev/null 2>&1 || { rpm -q xinetd >/dev/null 2>&1 && ! systemctl is-enabled xinetd.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active xinetd.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
