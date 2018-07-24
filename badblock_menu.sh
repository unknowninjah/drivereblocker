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

options=("Scan Drives" "Prepare Drives" "Start Check" "Status" "Clean-Up")

select opt in "${options[@]}"
do
case $opt in
"Scan Drives")
clear
echo =============================
echo -n "Drive's Detected: "
sg_scan | awk '{print $1}'|grep -v 'sg0:\|sg1:\|sg2:\|sg3:\|sg4:' -c
echo =============================
sleep .5
./badblock_menu.sh
;;

"Prepare Drives")
clear
for d in {0..99}
do
echo badblocks -vns -e10 -o HDD$d.txt /dev/sg$d >> HDD$d.sh
echo "./HDD$d.sh 2>/dev/null &" >> start_block_check.sh
done
chmod +x HDD*
chmod +x start_block_check.sh
clear
echo ""
echo "Script files have been created, ready for Block Check."
echo ""
;;

"Start Check")	
  clear
  if
  ls|grep start_block_check.sh --silent
  then 
  ./start_block_check.sh 2>/dev/null
  sleep 1m
  else
  echo ""
  echo "Please prepare drives first, then start check."
  echo ""
  ./badblock_menu.sh
  fi 
;;

"Status")
  clear
  echo ==========Progress===========
  for d in {0..99}
  do
  if
  ps -a |grep HDD$d.sh --silent
  then 
  echo "Drive $d is still in progress."
  fi
  done
;;

"Clean-Up")
for d in {0..99}
do
rm -rf HDD$d.sh
rm -rf start_block_check.sh
done
echo "Script files have been removed."
./badblock_menu.sh
;;
*)
echo invalid option
;;
esac
done 
