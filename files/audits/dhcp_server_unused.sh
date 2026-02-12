source /tmp/lib.sh

if ! rpm -q dhcp-server >/dev/null 2>&1 || { rpm -q dhcp-server >/dev/null 2>&1 && ! systemctl is-enabled dhcpd.service dhcpd6.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active dhcpd.service dhcpd6.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
