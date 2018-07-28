rm -rf test.log
clear
echo "Test Starting..."
for i in {0..99}
do
D1=$(lsscsi -g | grep sg$i|awk '{print $6}'|grep sd)
D2=$(lsscsi -g | grep sg$i|awk '{print $7}'|grep sd)
D3=$(lsscsi -g | grep sg$i|awk '{print $8}'|grep sd)
D4=$(lsscsi -g | grep sg$i|awk '{print $9}'|grep sd)

smartctl -t short $D1 >> test.log
smartctl -t short $D2 >> test.log
smartctl -t short $D3 >> test.log
smartctl -t short $D4 >> test.log

done
clear
echo -n "Testing."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
sleep 5s
echo -n "."
clear
echo "SMART test Complete!"
echo ""
./menu.sh
