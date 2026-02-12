source /tmp/lib.sh

if ! rpm -q autofs >/dev/null 2>&1 || { rpm -q autofs >/dev/null 2>&1 && ! systemctl is-enabled autofs.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active autofs.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
