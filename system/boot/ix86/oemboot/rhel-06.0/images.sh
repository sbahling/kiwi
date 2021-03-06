#!/bin/sh
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

echo "Configure image: [$kiwi_iname]..."

#==========================================
# setup config.oempartition if required
#------------------------------------------
baseSetupOEMPartition

#==========================================
# remove unneded kernel files
#------------------------------------------
rhelStripKernel

#==========================================
# remove unneeded files
#------------------------------------------
rhelStripInitrd

#==========================================
# umount /proc
#------------------------------------------
umount /proc &>/dev/null

exit 0
