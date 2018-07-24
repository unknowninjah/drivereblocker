echo badblocks -vn -s -e10 -o HDD0.txt /dev/sdc >> HDD0.sh
echo badblocks -vn -s -e10 -o HDD1.txt /dev/sdd >> HDD1.sh
echo badblocks -vn -s -e10 -o HDD2.txt /dev/sde >> HDD2.sh
echo badblocks -vn -s -e10 -o HDD3.txt /dev/sdf >> HDD3.sh
echo badblocks -vn -s -e10 -o HDD4.txt /dev/sdg >> HDD4.sh
echo badblocks -vn -s -e10 -o HDD5.txt /dev/sdh >> HDD5.sh
echo badblocks -vn -s -e10 -o HDD6.txt /dev/sdi >> HDD6.sh
echo badblocks -vn -s -e10 -o HDD7.txt /dev/sdj >> HDD7.sh
echo badblocks -vn -s -e10 -o HDD8.txt /dev/sdk >> HDD8.sh

echo "./HDD0.sh &" >> start_block_check.sh
echo "./HDD1.sh &" >> start_block_check.sh
echo "./HDD2.sh &" >> start_block_check.sh
echo "./HDD3.sh &" >> start_block_check.sh
echo "./HDD4.sh &" >> start_block_check.sh
echo "./HDD5.sh &" >> start_block_check.sh
echo "./HDD6.sh &" >> start_block_check.sh
echo "./HDD7.sh &" >> start_block_check.sh
echo "./HDD8.sh  " >> start_block_check.sh

chmod +x HDD*
chmod +x start_block_check.sh
