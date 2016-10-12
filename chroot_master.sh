#! /bin/sh
# krhowto_2
# Path to partition you will work on
PFAD="/media/sde5"
# To use the Internet add your nameserver into the chroot folder
cp /etc/resolv.conf $PFAD/knx/source/KNOPPIX/etc/resolv.conf
# Allow X-based programs in chroot
[ -e $PFAD/knx/source/KNOPPIX/home/knoppix/.Xauthority ] \
   && rm $PFAD/knx/source/KNOPPIX/home/knoppix/.Xauthority
cp /home/knoppix/.Xauthority $PFAD/knx/source/KNOPPIX/home/knoppix
chown knoppix:knoppix $PFAD/knx/source/KNOPPIX/home/knoppix/.Xauthority
# prepare enviroment for chroot
mount --bind /dev $PFAD/knx/source/KNOPPIX/dev
mount -t proc proc $PFAD/knx/source/KNOPPIX/proc
mount -t sysfs sysfs $PFAD/knx/source/KNOPPIX/sys
mount --bind /dev/pts $PFAD/knx/source/KNOPPIX/dev/pts
mount --bind /tmp $PFAD/knx/source/KNOPPIX/tmp

