#!/bin/bash

database=$1
table=$2

if [ "$#" -ne 2 ]; then
        echo "Error: parameters problem"
elif [ ! -d "$database" ]; then
	echo "Error: DB does not exist"
elif [ ! -f "$database/$table" ]; then
	echo "Error: The table doesn't exists"
else	
	./P.sh "$database" #locking the database
    rm "$database/$table" #removing table file
	echo "OK: table deleted"
	./V.sh "$database" #unlocking the database
fi
