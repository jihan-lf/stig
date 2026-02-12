source /tmp/lib.sh

if ! rpm -q rpcbind >/dev/null 2>&1 || { rpm -q rpcbind >/dev/null 2>&1 && ! systemctl is-enabled rpcbind.socket rpcbind.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active rpcbind.socket rpcbind.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
