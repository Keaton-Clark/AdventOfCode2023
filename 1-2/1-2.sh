#!/usr/bin/env bash
input="./input.txt"
work="./work.txt"
cp $input $work
sed -i 's/one/one1one/g' $work
sed -i 's/two/two2two/g' $work
sed -i 's/three/three3three/g' $work
sed -i 's/four/four4four/g' $work 
sed -i 's/five/five5five/g' $work 
sed -i 's/six/six6six/g' $work
sed -i 's/seven/seven7seven/g' $work
sed -i 's/eight/eight8eight/g' $work
sed -i 's/nine/nine9nine/g' $work
sum="0"
while read -r line; do
	sum=$(expr $sum + $(echo "$line" | grep -o [0-9] | xargs echo | awk '{print $1$(NF)}'))
done < $work
echo $sum
