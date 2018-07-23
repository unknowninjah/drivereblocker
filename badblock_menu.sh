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
