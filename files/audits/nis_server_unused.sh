source /tmp/lib.sh

if ! rpm -q ypserv >/dev/null 2>&1 || { rpm -q ypserv >/dev/null 2>&1 && ! systemctl is-enabled ypserv.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active ypserv.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
