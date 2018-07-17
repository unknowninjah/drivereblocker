#!/bin/bash
if
uptime|awk '{print $3" "$4}'|grep days --silent
then
echo -n "System Uptime: " && uptime|awk '{print $3" "$4}'
else
echo -n "System Uptime: " && uptime|awk '{print $3}'
fi
echo =============================
PS3='Enter Choice: '
COLUMNS=12

options=("Scan Drives" "Make Re-Block files" "Remove Re-Block files" "Run" "Status" "Quit")

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

"Make Re-Block files")
	clear
	for d in {3..99}
	do
	echo sg_format --format --size=512 /dev/sg$d >> hdd$d.sh
	echo "./hdd$d.sh 2>/dev/null &" >> start_format.sh
	chmod +x hdd*
	chmod +x start_format.sh
	done
	clear
	echo "Re-Block files have been created."
	./menu.sh
	;;

"Remove Re-Block files")
	clear
	for d in {3..99}
	do
	rm -rf hdd$d.sh
	rm -rf start_format.sh  
	done
	clear
	echo "Re-Block files have been removed."
	./menu.sh
	;;

"Run")	
	clear
	./start_format.sh
	sleep 1
	;;

"Status")
        for d in {3..99}
	do
	if
	ps -a |grep hdd$d.sh --silent
	then 
	echo "Drive $d is still in progress."
	fi
	done
	;;

"Quit")
	clear
	sleep .5
	break
	;;

*)
	echo invalid option
	;;
esac
done                            
