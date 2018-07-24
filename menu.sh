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

options=("Scan Drives" "Prepare Drives" "Start Format" "Status" "Reboot")

select opt in "${options[@]}"
do
case $opt in
"Scan Drives")
	clear
	echo =============================
        echo -n "Drive's Detected: "
	sg_scan | awk '{print $1}'|grep -v 'sg0:\|sg1:\|sg2:' -c
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
	ls|grep start_format.sh --silent
	then 
	./start_format.sh 2>/dev/null
	sleep 1m
	else
        echo ""
	echo "Please prepare drives first, then start format."
	echo ""
	./menu.sh
	fi 
        for d in {0..99}
        do
        rm -rf hdd$d.sh
        rm -rf start_format.sh
        done
        echo "Script files have been removed."
	./menu.sh
	;;

"Status")
	clear
        echo ==========Progress===========
	for d in {0..99}
	do
	if
	ps -a |grep hdd$d.sh --silent
	then 
	echo "Drive $d is still in progress."
	fi
	done
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
