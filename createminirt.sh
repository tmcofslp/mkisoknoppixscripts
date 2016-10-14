#!/bin/bash

SCRIPTPATH=$(readlink -f $0)
PFAD=$(dirname $SCRIPTPATH)
KNSRC="$PFAD/knx/source/KNOPPIX"
KMODULESDIR="lib/modules/2.6.24.7-rtai-3.6.1-smp-dbg"
KNKMOD="$KNSRC/$KMODULESDIR"
MINIRTNAME="2.6.24_g_minirt-debug"
MINIRTGZ="${MINIRTNAME}.gz"
MRTDESTD="$PFAD/knx/minirt"
MRTDIR="$MRTDESTD/minirtdir"
MRTMODDIR="$MRTDIR/modules"

for i in `cat modulesfilelist.txt`
do
	if [ ! -f $KNKMOD/$i ]; then
		echo "module $i not found!" >&2
		exit -1;
	fi
	cp $KNKMOD/$i $MRTMODDIR
done
cd $MRTDIR

find . | cpio -oH newc | gzip -9 > $MRTDESTD/$MINIRTGZ

cp $MRTDESTD/$MINIRTGZ $PFAD/knx/master/boot/
