source /tmp/lib.sh

if ! rpm -q cups >/dev/null 2>&1 || { rpm -q cups >/dev/null 2>&1 && ! systemctl is-enabled cups.socket cups.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active cups.socket cups.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
