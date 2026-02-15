source /tmp/lib.sh

expected=(
"-w /var/run/utmp -p wa -k session"
"-w /var/log/wtmp -p wa -k session"
"-w /var/log/btmp -p wa -k session"
)

fail=0

on_disk="$(awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

running="$(auditctl -l 2>/dev/null | awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')"

for line in "${expected[@]}"; do
  grep -Fxq -- "$line" <<< "$on_disk" || fail=1
  grep -Fxq -- "$line" <<< "$running" || fail=1
done

if [ "$fail" -eq 0 ]; then
  exit $PASS
else
  exit $FAIL
fi
