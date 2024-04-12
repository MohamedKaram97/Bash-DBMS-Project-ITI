#!/bin/bash
read -p "Enter DataBase Name : " DB
if [ -z "$DB" ]; then
        echo Please Enter Database Name
elif ! [[ "$DB" =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
        echo Invalid DataBase Name
elif [ -d "$DB" ]; then
        echo This DataBase already exist
else
        mkdir "$DB"
        echo DataBase Created Successfully
fi
