source /tmp/lib.sh

if ! rpm -q rsync-daemon >/dev/null 2>&1 || { rpm -q rsync-daemon >/dev/null 2>&1 && ! systemctl is-enabled rsyncd.socket rsyncd.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active rsyncd.socket rsyncd.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
