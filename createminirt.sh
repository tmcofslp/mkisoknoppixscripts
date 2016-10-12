#!/bin/bash

SCRIPTPATH=$(readlink -f $0)
PFAD=$(dirname $SCRIPTPATH)
KNSRC="$PFAD/knx/source/KNOPPIX"
KMODULESDIR="lib/modules/2.6.24.7-rtai-3.6.1-smp-dbg"
KNKMOD="$KNSRC/$KMODULESDIR"
MINIRTNAME="2.6.24_g_minirt-debug"
MINIRTGZ="${MINIRTNAME}.gz"
cd $PFAD/knx/minirt/minirtdir/modules
for i in `ls *.ko`; do find $KNKMOD -name $i -exec cp {} . \; ; done
cd $PFAD/knx/minirt/minirtdir/
find . | cpio -oH newc | gzip -9 > ../$MINIRTGZ
cp $PFAD/knx/minirt/$MINIRTGZ $PFAD/knx/master/boot/
