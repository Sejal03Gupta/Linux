#! /usr/bin/bash

read -p "Enter the directory path to analyze: " directory


if [ ! -d "$directory" ]
then
    echo "Error: Directory '$directory' not found."
    exit 
fi


total_size=0
file_count=0
largest_size=0
largest_file=""
smallest_size=-1  
smallest_file=""



calculate() {
    local file="$1"
    local size=$(stat -c %s "$file")
    
   
    total_size=$((total_size + size))
    

    if [ $size -gt $largest_size ]
    then
        largest_size=$size
        largest_file="$file"
    fi
    
    
    if [ $smallest_size -eq -1 ] || [ $size -lt $smallest_size ]
     then
        smallest_size=$size
        smallest_file="$file"
    fi
    
    
    ((file_count++))
}


while IFS= read -r -d '' file
do
    if [ -f "$file" ] 
    then
        calculate "$file"
    fi
done < <(find "$directory" -type f -print0)


if [ $file_count -gt 0 ]
then
    average_size=$((total_size / file_count))
fi


echo "Directory: $directory"
echo "Total number of files: $file_count"
echo "Total size of all files: $total_size bytes"
echo "Average file size: $average_size bytes"
echo "Largest file: $largest_file (Size: $largest_size bytes)"
echo "Smallest file: $smallest_file (Size: $smallest_size bytes)"


