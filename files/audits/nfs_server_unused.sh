source /tmp/lib.sh

if ! rpm -q nfs-utils >/dev/null 2>&1 || { rpm -q nfs-utils >/dev/null 2>&1 && ! systemctl is-enabled nfs-server.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active nfs-server.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
