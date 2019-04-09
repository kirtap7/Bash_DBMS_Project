#!/bin/bash

database=$1
table=$2
columns=$3

if [ "$#" -ne 3 ]; then
    echo "Error: parameters problem"
elif [ ! -d "$database" ]; then
	echo "Error: DB does not exist"
elif [ -f "$database/$table" ]; then
	echo "Error: The table already exists"
else	
	./P.sh "$database" #locking the database
	echo > "$database/$table"
	echo "$columns" > "$database/$table" #creating heading with columns
	echo "OK: table created"
	./V.sh "$database" #unlocking the database
fi
