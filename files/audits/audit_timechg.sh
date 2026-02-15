source /tmp/lib.sh

expected=(
"-a always,exit -F arch=b64 -S adjtimex,settimeofday -k time-change"
"-a always,exit -F arch=b32 -S adjtimex,settimeofday -k time-change"
"-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -k time-change"
"-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -k time-change"
"-w /etc/localtime -p wa -k time-change"
)

expected_running=(
"-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change"
"-a always,exit -F arch=b32 -S settimeofday,adjtimex -F key=time-change"
"-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change"
"-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -F key=time-change"
"-w /etc/localtime -p wa -k time-change"
)

fail=0

on_disk_syscalls="$(awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/adjtimex/ \
 ||/settimeofday/ \
 ||/clock_settime/ ) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

on_disk_watches="$(awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

on_disk="${on_disk_syscalls}"$'\n'"${on_disk_watches}"

running_syscalls="$(auditctl -l 2>/dev/null | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/adjtimex/ \
 ||/settimeofday/ \
 ||/clock_settime/ ) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

running_watches="$(auditctl -l 2>/dev/null | awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

running="${running_syscalls}"$'\n'"${running_watches}"

for line in "${expected[@]}"; do
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
