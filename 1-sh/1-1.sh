#!/usr/bin/env bash
input="./input.txt"
while read -r line; do
	sum=$(expr $sum + $(echo "$line" | grep -o [0-9] | xargs echo | awk '{print $1$(NF)}'))
done < $input
echo $sum
