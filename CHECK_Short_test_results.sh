rm -rf test_results.log
clear
for i in {0..99}
do
echo -n "."
D1=$(lsscsi -g | grep sg$i|awk '{print $6}'|grep sd)
D2=$(lsscsi -g | grep sg$i|awk '{print $7}'|grep sd)
D3=$(lsscsi -g | grep sg$i|awk '{print $8}'|grep sd)
D4=$(lsscsi -g | grep sg$i|awk '{print $9}'|grep sd)
smartctl -a $D1 >> test_results.log
smartctl -a $D2 >> test_results.log
smartctl -a $D3 >> test_results.log
smartctl -a $D4 >> test_results.log

done

clear  
echo "Failed Drive(s):"
echo "==============================="
cat test_results.log |grep '=== START OF INFORMATION SECTION ===' -A13|grep -v 'Revision\|Logical block size\|Rotation Rate\|Logical Unit id\|Device type\|Transport protocol\|Local Time is'|grep failed -B2|grep -v 'failed\|NOT READY'|grep Serial|uniq

