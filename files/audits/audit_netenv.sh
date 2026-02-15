source /tmp/lib.sh

expected=(
"-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale"
"-a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale"
"-w /etc/issue -p wa -k system-locale"
"-w /etc/issue.net -p wa -k system-locale"
"-w /etc/hosts -p wa -k system-locale"
"-w /etc/hostname -p wa -k system-locale"
"-w /etc/sysconfig/network -p wa -k system-locale"
"-w /etc/sysconfig/network-scripts/ -p wa -k system-locale"
"-w /etc/NetworkManager -p wa -k system-locale"
)

expected_running_includes=(
"-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale"
"-a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale"
"-w /etc/issue -p wa -k system-locale"
"-w /etc/issue.net -p wa -k system-locale"
"-w /etc/hosts -p wa -k system-locale"
"-w /etc/hostname -p wa -k system-locale"
"-w /etc/sysconfig/network -p wa -k system-locale"
"-w /etc/sysconfig/network-scripts -p wa -k system-locale"
"-w /etc/NetworkManager -p wa -k system-locale"
)

fail=0

on_disk_syscalls="$(awk '/^*-a *always, exit/ \
&& /-F *arch=b(32|64)/ \
&& /-S/ && (/sethostname/ \
|| /setdomainname/) \
&& (/skey= *[!-~]* *$/ || /-k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

on_disk_watches="$(awk '/^ *-w/ \
&& (/etc\/issue/ \
|| /etc\/issue.net/ \
|| /etc\/hosts/ \
|| /etc\/sysconfig\/network/ \
|| /etc\/hostname/ \
|| /etc\/NetworkManager/) \
&& / +-p *wa/ \
&& (/ key= *[!-~]* *$/ || /-k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

on_disk="${on_disk_syscalls}"$'\n'"${on_disk_watches}"

running_syscalls="$(auditctl -l 2>/dev/null | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

running_watches="$(auditctl -l 2>/dev/null | awk '/^ *-w/ \
&&(/etc\/issue/ \
 || /etc\/issue.net/ \
 || /etc\/hosts/ \
 || /etc\/sysconfig\/network/ \
 || /etc\/hostname/ \
 || /etc\/NetworkManager/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

running="${running_syscalls}"$'\n'"${running_watches}"

for line in "${expected[@]}"; do
  grep -Fxq -- "$line" <<< "$on_disk" || fail=1
done

for line in "${expected_running_includes[@]}"; do
  grep -Fxq -- "$line" <<< "$running" || fail=1
done

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
