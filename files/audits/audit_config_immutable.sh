source /tmp/lib.sh

expected="-e 2"
fail=0

last_on_disk="$(grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules 2>/dev/null | tail -1)"

if [ "$last_on_disk" = "$expected" ]; then
  exit $PASS
else
  exit $FAIL
fi
