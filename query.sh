#!/bin/bash

database=$1
table=$2
columns=$3

#count the number of existing columns in the table
col_num=`head -n 1 $1/$2 2>/dev/null | tr "," " " | wc -w` 

#find the max column number requested
max_col_req_num=`echo $3 | tr "," "\n" | sort -nr | head -n1`

#find the min column number requested
min_col_req_num=`echo $3 | tr "," "\n" | sort -n | head -n1`

#we accept only 2 or 3 arguments (only 2 arguments means that we print all the columns)
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then 
    echo "Error: parameters problem"
elif [ ! -d "$database" ]; then
	echo "Error: DB does not exist"
elif [ ! -f "$database/$table" ]; then
	echo "Error: the table does not exists"
    #if the max column number requested is not in the table OR if the min column is 0
elif [ $col_num -lt $max_col_req_num ] 2>/dev/null || [ $min_col_req_num -eq 0 ] 2>/dev/null; then
    echo "Error: column does not exist"
else
    ./P.sh "$database/$table" #locking the table
    #if there is no $3 then we print all the columns
    if [ ! $3 ]; then 
        echo "start_result"
        tail -n +2 "$database/$table"
        echo "end_result"
    else #if there is $3 we print the selected columns
        echo "start_result"
        tail -n +2 "$database/$table" | cut -d"," -f$3 2>/dev/null
        echo "end_result"
    fi
    ./V.sh "$database/$table" #unlocking the table
fi