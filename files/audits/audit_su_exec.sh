source /tmp/lib.sh

expected_on_disk=(
"-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
"-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
)

expected_running=(
"-a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"
"-a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"
)

fail=0

on_disk="$(awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

running="$(auditctl -l 2>/dev/null | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

for line in "${expected_on_disk[@]}"; do
  grep -Fxq -- "$line" <<< "$on_disk" || fail=1
done

for line in "${expected_running[@]}"; do
  grep -Fxq -- "$line" <<< "$running" || fail=1
done

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
