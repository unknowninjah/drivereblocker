clear

for i in {0..99}
do

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
echo "                      Drive $i Failed"
smartctl -a /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|Logical block size:'
else
smartctl -i /dev/sg$i 2>/dev/null |grep 'Vendor:\|Serial number:\|Product:'
smartctl -a /dev/sg$i 2>/dev/null |grep 'SMART Health\|Logical block size:'
fi

if
smartctl -i /dev/sg$i |grep ' INFORMATION SECTION' --silent
then
echo "============================================="
fi

fi
fi
done 
