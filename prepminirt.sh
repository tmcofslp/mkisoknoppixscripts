#! /bin/sh

SCRIPTPATH=$(readlink -f $0)
PFAD=$(dirname $SCRIPTPATH)
MINIRTNAME="2.6.24_g_minirt"
MINIRTGZ=${MINIRTNAME}.gz
MINIRTFOLDER="$PFAD/knx/minirt/"
SYSMNT="/cdrom/"
MRTSRCDIR="$MINIRTFOLDER/minirtdir"

if [ ! -e $MINIRTFOLDER ]; then
	mkdir -p $MINIRTFOLDER
fi
cp $SYSMNT/boot/$MINIRTGZ $MINIRTFOLDER
cd $MINIRTFOLDER
gunzip $MINIRTGZ 
if [ ! -e $MRTSRCDIR ]; then
	mkdir $MRTSRCDIR
fi

cd $MRTSRCDIR 
cpio -imd --no-absolute-filenames < $MINIRTFOLDER/$MINIRTNAME

