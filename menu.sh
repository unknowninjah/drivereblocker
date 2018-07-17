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

options=("Scan Drives" "Make Re-Block files" "Remove Re-Block files" "Run" "Quit")

select opt in "${options[@]}"
do
case $opt in
"Scan Drives")
	clear
	echo =============================
	sg_scan | awk '{print $1}'|grep -v 'sg0:\|sg1:\|sg2:'
	echo =============================
	./menu.sh
	;;

"Make Re-Block files")
	clear
	for d in {2..99}
	do
	#echo sg_format --format --size=512 /dev/sg$d >> hdd$d.sh
	echo echo test $d of 99 >> hdd$d.sh
	chmod +x hdd$d.sh
	done
	echo "Re-Block files have been created."
	./menu.sh
	;;

"Remove Re-Block files")
	clear
	for d in {2..99}
	do
	rm -rf hdd$d.sh
	done
	echo "Re-Block files have been removed."
	./menu.sh
	;;

"Run")
        for d in {2..99}
	do
	./hdd$d.sh 2>/dev/null
	done
	;;

"Quit")
	clear
	break
	exit
	;;

*)
	echo invalid option
	;;
esac
done                            
