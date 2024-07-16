#! /usr/bin/bash
input_file=$1
temp_file=$(mktemp)
sed -n "s/[[:punct:]]//p" $input_file | tr '[:upper:]' '[:lower:]' >> $temp_file

var=$(<"$temp_file")
words=($var)

declare -A freq

for word in ${words[@]}
do
	(( freq[$word]++ ))
done

for word in ${!freq[@]}
do
	echo " ${freq[$word]}   $word  "
done	

rm $temp_file


