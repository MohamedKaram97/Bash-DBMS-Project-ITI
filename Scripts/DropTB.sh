#!/bin/bash
read -p "Enter Table Name to Delete: " TB
if [ -z "$TB" ]; then
                echo "Please Enter Table Name"
elif [ -e $TB ]; then
                rm $TB
                TBMD="${TB}MD"
                rm $TBMD
                echo "Table Deleted Successfully"
else
                echo "Table does not exist"
fi
