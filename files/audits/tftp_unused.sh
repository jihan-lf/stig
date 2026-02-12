source /tmp/lib.sh

if ! rpm -q tftp-server >/dev/null 2>&1 || { rpm -q tftp-server >/dev/null 2>&1 && ! systemctl is-enabled tftp.socket tftp.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active tftp.socket tftp.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
