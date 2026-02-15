source /tmp/lib.sh

fail=0

for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
  for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f 2>/dev/null); do
    grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" \
      || { printf "Warning: '${PRIVILEGED}' not found in on disk configuration.\n"; fail=1; }
  done
done

RUNNING="$(auditctl -l 2>/dev/null)"
if [ -n "${RUNNING}" ]; then
  for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
    for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f 2>/dev/null); do
      printf -- "${RUNNING}" | grep -q "${PRIVILEGED}" && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" \
        || { printf "Warning: '${PRIVILEGED}' not found in running configuration.\n"; fail=1; }
    done
  done
else
  printf "ERROR: Variable 'RUNNING' is unset.\n"
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
