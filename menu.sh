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

options=("Scan Drives" "Start Format" "Status" "Health-Check" "Show Failed Drives" "Reboot")

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

"Start Format")	
        clear
        for d in {0..99}
        do
        echo sg_format --format --size=512 /dev/sg$d >> hdd$d.sh
	echo "./hdd$d.sh 2>/dev/null &" >> start_format.sh
        chmod +x hdd*
        chmod +x start_format.sh
        done
	
	echo "rm -rf hdd* start_format.sh" >> start_format.sh

	clear
        echo ""
        echo "Script files have been created, ready for format."
        echo ""


	clear
	echo ""
        if
        ps -a |grep sg_format --silent
        then
        echo " "
	echo "Please wait, for current format to complete!"
        echo " "
	fi || 
	echo ""
	if
	ls | grep start_format.sh --silent
	then 
	./start_format.sh 
	else
        echo ""
	echo "Please prepare drives first, then start format."
	echo ""
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

"Show Failed Drives")
clear
echo "Failed Drive(s)"
cat TheDrives.log 2>/dev/null |grep Failed -A2|grep -v 'Vendor\|Failed'
echo " "
echo " " 
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
