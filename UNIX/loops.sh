#!/bin/ksh
a=0
for n in $(seq 10)
do
 echo "n is $n, a is $a"
 a=$(expr $a + 3)
done

N=1
while [ $N -lt 10 ]
do
  echo "N is $N"
  N=$(expr $N + 1)
done
lettercount=0
IFS=,
cat data.csv | while read COL1 ELEPHANT; do 
  count=$(echo $COL2 | wc -c) 
  echo "col2 is $count letters long"; 
  lettercount=$(expr $lettercount + $count); 
  echo "in loop, letter count is $lettercount"
  echo "$ELEPHANT is col2"
done 
echo "letter count is $lettercount"