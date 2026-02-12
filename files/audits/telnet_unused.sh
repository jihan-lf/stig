source /tmp/lib.sh

if ! rpm -q telnet-server >/dev/null 2>&1 || { rpm -q telnet-server >/dev/null 2>&1 && ! systemctl is-enabled telnet.socket 2>/dev/null | grep -q 'enabled' && ! systemctl is-active telnet.socket 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
