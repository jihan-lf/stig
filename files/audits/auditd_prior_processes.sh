source /tmp/lib.sh

if grubby --info=ALL | grep -Pq '\baudit=1\b' && \
   grep -Psoq -- '^\h*GRUB_CMDLINE_LINUX="([^#\n\r]+\h+)?audit=1\b' /etc/default/grub; then
    exit $PASS
else
    exit $FAIL
fi
