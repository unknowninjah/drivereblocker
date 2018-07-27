today=$(date +%m-%d-%Y)
clear
echo -n "Checking drive health..."

for i in {0..99}
do
echo "."

if
smartctl -i /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|SMART\|Product:' |grep 'device lacks SMART capability' --silent
then
2>/dev/null
else

if
smartctl -i /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|SMART\|Product:' |grep 'USB\|DVD-ROM' --silent
then
2>/dev/null
else

if
smartctl -i /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|SMART\|Logical block size:\|Product:' |grep failed --silent
then
echo "                      Drive $i Failed" >> $today.log 
smartctl -a /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|Logical block size:' >> $today.log && echo "=====================================================" >> $today.log
else
smartctl -a /dev/sg$i 2>/dev/null |grep 'User Capacity\|Product:\|Vendor:\|Logical block size\|Form Factor\|Serial number\|SMART Health Status\|Non-medium error count' >> $today.log 
fi

if
smartctl -i /dev/sg$i |grep ' INFORMATION SECTION' --silent
then
echo "=====================================================" >> $today.log
fi

fi 

fi

done

echo "Drive health-check complete!"
echo " "
echo "Drive Status: "
echo "====================================================="

cat $today.log
