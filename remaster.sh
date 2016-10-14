#!/bin/bash
# krhowto_4
# Path to partition you will work on
SCRIPTPATH=$(readlink -f $0)
PFAD=$(dirname $SCRIPTPATH)
START=$(date +'%s')
MINIRTNAME="2.6.24_g_minirt-debug"
MINIRTGZ="${MINIRTNAME}.gz"
KERNELVER="2.6.24.7-rtai-3.6.1-smp-dbg"
KMODULESDIR="lib/modules/$KERNELVER"
KNSRC="$PFAD/knx/source/KNOPPIX"
KNKMOD="$KNSRC/$KMODULESDIR"
# Disable screensaver
# Build new inital RAM-disk
$PFAD/createminirt.sh
if [ $? -ne 0 ]; then
	echo "createminirt.sh failed!" >&2
	exit -1
fi
# Make the big  compressed filesystem KNOPPIX
cp $KNSRC/boot/vmlinuz-$KERNELVER $PFAD/knx/master/boot/atom-6-2.6.24-debug
mkisofs -input-charset ISO-8859-15 -R -l -D -V KNOPPIX_FS -quiet \
  -no-split-symlink-components -no-split-symlink-fields \
  -hide-rr-moved -cache-inodes $PFAD/knx/source/KNOPPIX \
  | /usr/bin/create_compressed_fs -q -B 65536 -t 8 -L 9 \
  -f $PFAD/knx/isotemp - $PFAD/knx/master/KNOPPIX/KNOPPIX
 
