#!/bin/bash

read -p "Enter DataBase Name : " DB
if [ -z "$DB" ]; then
        echo Please Enter DataBase Name
elif [ -d "$DB" ]; then
        cd $DB
        export CurrDB=$DB
        echo Connected To $DB Successfully 
        source ../.././TableMain.sh
        break
else
        echo This DataBase doesnot exist
fi
