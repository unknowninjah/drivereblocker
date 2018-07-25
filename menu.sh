#!/bin/bash
if
uptime|awk '{print $3" "$4}'|grep days --silent
then
echo -n "System Uptime: " && uptime|awk '{print $3" "$4}'
else
echo -n "Address: " && ifconfig|grep 192|awk '{print $2}'
echo -n "System Uptime: " && uptime|awk '{print $3}'
fi
echo =============================
PS3='Enter Choice: '
COLUMNS=12

options=("Scan Drives" "Prepare Drives" "Start Format" "Status" "Health-Check"  "Reboot")

select opt in "${options[@]}"
do
case $opt in
"Scan Drives")
	clear
	echo =============================
        echo -n "Drive's Detected: "
	sg_scan | awk '{print $1}'|grep -v 'sg0:\|sg1:\|sg2:\|sg3:\|sg4:\|sg5:' -c
	echo =============================
	sleep .5
	./menu.sh
	;;

"Prepare Drives")
	clear
	for d in {0..99}
	do
        echo sg_format --format --size=512 /dev/sg$d >> hdd$d.sh
	echo "./hdd$d.sh 2>/dev/null &" >> start_format.sh
	chmod +x hdd*
	chmod +x start_format.sh
	done
	clear
	echo ""
	echo "Script files have been created, ready for format."
	echo ""
	./menu.sh
	;;

"Start Format")	
	clear

        if
        ps -a |grep sg_format --silent
        then
        echo " "
	echo "Please wait, for current format to complete!"
        echo " "
	fi || 


	if
	ls|grep start_format.sh --silent
	then 
	./start_format.sh 2>/dev/null
	sleep 1m
	else
        echo ""
	echo "Please prepare drives first, then start format."
	echo ""
	./menu.sh
	fi &&
       
	if
	ls |grep start_format --silent
	then 
	for d in {0..99}
        do
        rm -rf hdd$d.sh
        rm -rf start_format.sh
        done
        echo "Script files have been removed."
	else
	./menu.sh
	fi
	;;

"Status")
	clear
        echo ==========Progress===========
	echo -n "Drive(s) still in progress: " && ps -a|grep format -c 
	echo =============================
	echo " "
	./menu.sh
	;;

"Health-Check")
clear
./health_check.sh
./menu.sh
;;


"Reboot")
	reboot now
	;;

*)
	echo invalid option
	;;
esac
done                            
