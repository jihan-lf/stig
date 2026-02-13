source /tmp/lib.sh

# systemd-journal-remote installed (only if journald is chosen)
if systemctl is-active --quiet rsyslog; then
  exit $PASS
fi

if systemctl is-active --quiet systemd-journald; then
  if rpm -q systemd-journal-remote &>/dev/null; then exit $PASS; fi
  exit $FAIL
fi

exit $FAIL
