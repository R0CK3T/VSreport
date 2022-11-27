#!/bin/bash


echo "pointer here"
sysdisk=`sudo cat /proc/self/mounts | awk -F' ' '{print $1}' | grep /dev | sort | uniq  | grep -v loop | sed 's/.$//'`

echo $sysdisk
echo "script started" > /tmp/log.txt
echo "script started"


sudo fdisk -l  | grep "Disk /" | grep -v "loop\|$sysdisk" | awk -F': ' '{print $1}' | awk -F' ' '{print $2}' > /tmp/disks.txt
cat /tmp/disks.txt >> /tmp/log.txt




if (whiptail --title "FREE BLANCCO" --yesno "Are you sure you want to wipe the disks on this machine ? " 8 78); then
    echo "User selected Yes, exit status was $?."

while read disk; do

echo "$disk" ;

sudo dd if=/dev/zero of=$disk bs=512 count=1 ;

done </tmp/disks.txt

echo "script finished" >> /tmp/log.txt
echo "script finished"

disks=`cat /tmp/disks.txt`

whiptail --msgbox -- "$disks Disks have been wiped 100% rebooting now ... " 8 78

sleep 2;

echo 1 > /proc/sys/kernel/sysreq
echo b > /proc/sysreq-trigger
sudo reboot -n



else

    echo "User selected No, exit status was $?."


whiptail --msgbox -- "$disks NOT WIPED... rebooting now " 8 78

sleep 2;

echo 1 > /proc/sys/kernel/sysreq
echo b > /proc/sysreq-trigger
sudo reboot -n




fi

