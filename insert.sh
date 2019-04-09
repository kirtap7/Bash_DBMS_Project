#!/bin/bash

database=$1
table=$2
tuple=$3

# counting the columns in the table and in $3
# in case the DB or Table doesn't exist 2>/dev/null prevents the error output in the terminal
col_num=`head -n 1 "$1/$2" 2>/dev/null | tr "," " " | wc -w` 
tuple_num=`echo "$3" | tr "," " " | wc -w`

if [ "$#" -ne 3 ]; then
    echo "Error: parameters problem"
elif [ ! -d "$database" ]; then
	echo "Error: DB does not exist"
elif [ ! -f "$database/$table" ]; then
	echo "Error: the table does not exists"
elif [ $col_num -ne $tuple_num ]; then
    echo "Error: number of columns in tuple does not match schema"
else
    ./P.sh "$database/$table" #locking the table
	echo "$tuple" >> "$database/$table" #appending tuple to existing columns
    echo "OK: tuple inserted"
    ./V.sh "$database/$table" #unlocking the table
fi