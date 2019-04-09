 _           _                   _   _                 
(_)_ __  ___| |_ _ __ _   _  ___| |_(_) ___  _ __  ___ 
| | '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __|
| | | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \
|_|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/
=======================================================

FILES INCLUDED IN THE PROJECT

OS_Project_Report.pdf	client.sh		delete_table.sh
P.sh			create_database.sh	insert.sh
README.txt		create_table.sh		query.sh
V.sh			delete_database.sh	server.sh        


********** HOW TO RUN **********

1. start the server in one terminal
>>> ./server.sh

2. start one (or multiple) client, specifying the ID, in a different terminal(s)
>>> ./client.sh [ID]
example >>> ./client.sh 34

3. type your requests in the client.sh process

    these are the commands allowed, in brackets [] the requested arguments:

    >>> create_database [database_name]
    example >>> create_database company
    result  >>> OK: DB created

    >>> create_table [database_name ; table_name ; columns_heading]
    example >>> create_table company employees ID,name,phone
    result  >>> OK: Table created

    >>> insert [database_name ; table_name ; tuple]
    example >>> insert company employees 012,Steve,3402345234
    result  >>> OK: Tuple inserted

    >>> select [database_name ; table_name ; columns_number]
    example >>> select company employees 1,2
    result  >>> Result of query:
            >>> 012,Steve

    >>> delete_table [database_name ; table_name] 
    example >>> delete_table employees
    result  >>> OK: Table deleted

    >>> delete_database [database_name]
    example >>> delete_database company
    result  >>> OK: DB deleted


********** HOW TO QUIT **********

To terminate you programs, type the following commands in the client process:

type "exit" to exit the client(s)
example >>> exit
result  >>> exiting the client

type "shutdown" to shutdown the server and exit the client(s)
example >>> shutdown
result  >>> server shut down

from keyboard input press CTRL+C

=======================================================
Created by Patrick Tomasini Malatesta
UCD Student ID 18205940
Nov-2018
