source /tmp/lib.sh

fail=0
UID_MIN="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"

if [ -n "${UID_MIN}" ]; then
  on_disk="$(awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chcon/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules 2>/dev/null)"

  running="$(auditctl -l 2>/dev/null | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chcon/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")"

  expected_on_disk="-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng"
  expected_running="-a always,exit -S all -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_chng"

  grep -Fxq -- "$expected_on_disk" <<< "$on_disk" || fail=1
  grep -Fxq -- "$expected_running" <<< "$running" || fail=1
else
  printf "ERROR: Variable 'UID_MIN' is unset.\n"
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
