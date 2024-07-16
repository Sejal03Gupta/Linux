#! /usr/bin/bash


for filename in $@
do 
    if ! test -e $filename
    then
    touch $filename
    fi
    extension=$(echo $filename | cut -d "." -f 2)
    if ! test -d $extension
    then
    mkdir $extension
    fi
    mv $filename "./$extension/$filename"
done
