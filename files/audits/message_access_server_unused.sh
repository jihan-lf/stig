source /tmp/lib.sh

if ! rpm -q dovecot cyrus-imapd >/dev/null 2>&1 || { rpm -q dovecot cyrus-imapd >/dev/null 2>&1 && ! systemctl is-enabled dovecot.socket dovecot.service cyrus-imapd.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active dovecot.socket dovecot.service cyrus-imapd.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL
