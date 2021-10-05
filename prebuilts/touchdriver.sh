#!/system/bin/sh

echo "touchdriver.sh starting in 5 seconds..." > /tmp/touchdriver.log
sleep 5
fastboot=$(getprop ro.boot.bootreason | cut -d, -F2)
if [[ $fastboot == "bootloader" || $fastboot == "longkey" || $fastboot == "reboot"  || $fastboot == "recovery" ]]
then
	echo "... loading driver because bootreason = ${fastboot}" >> /tmp/touchdriver.log
	insmod /system/lib64/videobuf2-memops.ko  >> /tmp/touchdriver.log
	insmod /system/lib64/videobuf2-vmalloc.ko >> /tmp/touchdriver.log
	insmod /system/lib64/heatmap.ko   >> /tmp/touchdriver.log
	insmod /system/lib64/ftm5.ko >> /tmp/touchdriver.log
	insmod /system/lib64/sec_touch.ko >> /tmp/touchdriver.log
else
	echo "... SKIPPING driver because bootreason = ${fastboot}" >> /tmp/touchdriver.log
fi
