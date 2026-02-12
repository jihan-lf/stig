source /tmp/lib.sh

if ! rpm -q samba >/dev/null 2>&1 || { rpm -q samba >/dev/null 2>&1 && ! systemctl is-enabled smb.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active smb.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
