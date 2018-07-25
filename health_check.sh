today=$(date +%m-%d-%Y)
clear
echo -n "Checking drive health..."
for i in {0..99}
do
echo "."
smartctl -a /dev/sg$i 2>/dev/null|grep 'Product:\|Vendor:\|Logical block size\|Form Factor\|Serial number\|SMART Health Status\|Non-medium error count' >> $today.log && echo "======================================" >> $today.log
done
echo "Drive health-check complete!"
echo " "
echo "Drive Status: "
echo "======================================"
cat $today.log
