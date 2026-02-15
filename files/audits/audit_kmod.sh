source /tmp/lib.sh

fail=0

on_disk_syscalls="$(awk '/^ *-a *always,exit/ \
 &&/ -F *arch=b(32|64)/ \
 &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
 &&/ -S/ \
 &&(/init_module/ \
 ||/finit_module/ \
 ||/delete_module/ \
 ||/create_module/ \
 ||/query_module/) \
 &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

UID_MIN="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"
if [ -n "${UID_MIN}" ]; then
  on_disk_kmod="$(awk "/^ *-a *always,exit/ \
 &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
 &&/ -F *auid>=${UID_MIN}/ \
 &&/ -F *perm=x/ \
 &&/ -F *path=\/usr\/bin\/kmod/ \
 &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules 2>/dev/null)"
else
  printf "ERROR: Variable 'UID_MIN' is unset.\n"
  fail=1
  on_disk_kmod=""
fi

running_syscalls="$(auditctl -l 2>/dev/null | awk '/^ *-a *always,exit/ \
 &&/ -F *arch=b(32|64)/ \
 &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
 &&/ -S/ \
 &&(/init_module/ \
 ||/finit_module/ \
 ||/delete_module/ \
 ||/create_module/ \
 ||/query_module/) \
 &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

if [ -n "${UID_MIN}" ]; then
  running_kmod="$(auditctl -l 2>/dev/null | awk "/^ *-a *always,exit/ \
 &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
 &&/ -F *auid>=${UID_MIN}/ \
 &&/ -F *perm=x/ \
 &&/ -F *path=\/usr\/bin\/kmod/ \
 &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)")"
else
  running_kmod=""
fi

expected_on_disk_syscall="-a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F auid>=${UID_MIN} -F auid!=unset -k kernel_modules"
expected_on_disk_kmod="-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k kernel_modules"

expected_running_syscall="-a always,exit -F arch=b64 -S create_module,init_module,delete_module,query_module,finit_module -F auid>=${UID_MIN} -F auid!=-1 -F key=kernel_modules"
expected_running_kmod="-a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=kernel_modules"

if [ -n "${UID_MIN}" ]; then
  grep -Fxq -- "$expected_on_disk_syscall" <<< "$on_disk_syscalls" || fail=1
  grep -Fxq -- "$expected_on_disk_kmod" <<< "$on_disk_kmod" || fail=1
  grep -Fxq -- "$expected_running_syscall" <<< "$running_syscalls" || fail=1
  grep -Fxq -- "$expected_running_kmod" <<< "$running_kmod" || fail=1
fi

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
