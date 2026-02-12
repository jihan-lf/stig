source /tmp/lib.sh

if ! rpm -q vsftpd >/dev/null 2>&1 || { rpm -q vsftpd >/dev/null 2>&1 && ! systemctl is-enabled vsftpd.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active vsftpd.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
