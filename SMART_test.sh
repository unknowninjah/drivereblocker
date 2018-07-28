echo "Testing Drives"
for i in {a..i}
do
smartctl -t short /dev/sd$i 2>/dev/null 
done
