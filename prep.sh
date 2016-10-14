#! /bin/sh
# krhowto_1
# Path to partition you will work on
SCRIPTPATH=$(readlink -f $0)
PFAD=$(dirname $SCRIPTPATH)
SYSMNT="/cdrom/"
START=$(date +'%s')
MINIRTNAME="2.6.24_g_minirt"
MINIRTGZ=${MINIRTNAME}.gz
SWAPFILE="${PFAD}/swapfile"
# Disable screensaver
xscreensaver-command -exit
echo "file=$MINIRTGZ"
# One sub-directory will be used for the Master-CD
mkdir -p $PFAD/knx/master
cd $PFAD/knx
# You will need a swapfile

if [ ! -f $SWAPFILE ]; then
	if [ -e $SWAPFILE ]; then
		rm $SWAPFILE
	fi
	dd if=/dev/zero of=$SWAPFILE bs=1M count=500
	mkswap $SWAPFILE ; 
fi

swapon $SWAPFILE
# Make a sub-directory for the source
mkdir -p $PFAD/knx/source/KNOPPIX
echo "Copy the KNOPPIX files to your source directory."
echo "This will take a long time!"
cp -rp /KNOPPIX/* $PFAD/knx/source/KNOPPIX
# Additionally, copy the files to build the ISO later
rsync -aH --exclude="KNOPPIX/KNOPPIX*" $SYSMNT $PFAD/knx/master
# gunzip inital RAM-disk
eval $PFAD/prepminirt.sh
echo -e "\nFinished! Used time: $(expr $(expr $(date +'%s') - $START) / 60) min. \
  and $(expr $(expr $(date +'%s') - $START) % 60) sec."
