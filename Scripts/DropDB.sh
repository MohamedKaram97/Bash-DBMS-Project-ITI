#!/bin/bash
   read -p "Enter the name of the database to drop: " DropDBName
   if [ -z "$DropDBName" ]
   then
      echo "Invalid input. Database name cannot be empty."
   elif [ -e "$DropDBName" ]
   then
      rm -r $DropDBName
      echo "Database '$DropDBName' dropped successfully."
   else
      echo "Database '$DropDBName' does not exist."
   fi
