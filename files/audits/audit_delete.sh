source /tmp/lib.sh

fail=0
UID_MIN="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"

if [ -n "${UID_MIN}" ]; then
  on_disk="$(awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules 2>/dev/null)"

  running="$(auditctl -l 2>/dev/null | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")"

  expected_on_disk=(
"-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=${UID_MIN} -F auid!=unset -k delete"
"-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F auid>=${UID_MIN} -F auid!=unset -k delete"
)

  expected_running=(
"-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=${UID_MIN} -F auid!=-1 -F key=delete"
"-a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=${UID_MIN} -F auid!=-1 -F key=delete"
)

  for line in "${expected_on_disk[@]}"; do
    grep -Fxq -- "$line" <<< "$on_disk" || fail=1
  done

  for line in "${expected_running[@]}"; do
    grep -Fxq -- "$line" <<< "$running" || fail=1
  done
else
  printf "ERROR: Variable 'UID_MIN' is unset.\n"
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
