source /tmp/lib.sh

fail=0

SUDO_LOG_FILE="$(grep -r logfile /etc/sudoers* 2>/dev/null | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g')"

if [ -n "${SUDO_LOG_FILE}" ]; then
  on_disk="$(awk "/^ *-w/ \
&&/${SUDO_LOG_FILE}/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules 2>/dev/null)"

  running="$(auditctl -l 2>/dev/null | awk "/^ *-w/ \
&&/${SUDO_LOG_FILE}/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")"

  expected="-w $(printf '%s' "${SUDO_LOG_FILE}" | sed 's|\\\/|/|g') -p wa -k sudo_log_file"

  grep -Fxq -- "$expected" <<< "$on_disk" || fail=1
  grep -Fxq -- "$expected" <<< "$running" || fail=1
else
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
