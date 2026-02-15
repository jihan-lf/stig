source /tmp/lib.sh

expected=(
"-w /etc/group -p wa -k identity"
"-w /etc/passwd -p wa -k identity"
"-w /etc/gshadow -p wa -k identity"
"-w /etc/shadow -p wa -k identity"
"-w /etc/security/opasswd -p wa -k identity"
"-w /etc/nsswitch.conf -p wa -k identity"
"-w /etc/pam.conf -p wa -k identity"
"-w /etc/pam.d -p wa -k identity"
)

fail=0

on_disk="$(awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/ \
 ||/\/etc\/nsswitch.conf/ \
 ||/\/etc\/pam.conf/ \
 ||/\/etc\/pam.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 2>/dev/null)"

running="$(auditctl -l 2>/dev/null | awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/ \
 ||/\/etc\/nsswitch.conf/ \
 ||/\/etc\/pam.conf/ \
 ||/\/etc\/pam.d/) \
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
