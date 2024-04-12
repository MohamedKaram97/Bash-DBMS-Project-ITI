#!/bin/bash
read -p "Enter Table Name : " TB
if [ -z "$TB" ]; then
   echo "Please Enter Table Name"
elif ! [[ "$TB" =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
    echo "Invalid Table Name"
elif [ -f $TB ]; then
        echo This Table  already exist
else
        flag=0
        touch $TB
        TBMD="${TB}MD"
        touch $TBMD
        while true; do
                read -p "Enter Number of Columns : " Cols
                if [ -z "$Cols" ]; then
                        echo "Please Enter Number of Columns"
                elif ! [[ "$Cols" =~ ^[0-9]+$ ]]; then
                        echo "Invalid Number"
                else
                        break
                fi
        done
        for ((i=0;i<$Cols;i++))
        do
                line=""
                while true; do
                        f=false
                        read -p "Enter Column Name: " ColName
                        for ((j=1;j<=i;j++)); do
                                colname=$(awk -v j="$j" 'BEGIN{FS=":"}{ if (NR==j) print $1}' "${TB}MD")
                                if [[ "$ColName" == "$colname" ]]; then
                                        echo Invalid Column Name
                                        f=true
                                        break
                                fi
                        done
                        if [ $f == "false" ]; then
                                if [[ "$ColName" =~ ^[a-zA-Z][a-zA-Z0-9]*$ ]]; then
                                        break
                                else
                                        echo "Invalid Column Name"
                                fi
			fi
                done
                line+="${ColName}"
                while true; do
                        read -p "Enter Column DataType (int/string): " ColType
                        if [[ "$ColType" =~ ^[Ii][Nn][Tt]$ || "$ColType" =~ ^[Ss][Tt][Rr][Ii][Nn][Gg]$ ]]; then
                                ColType="${ColType,,}"
                                break
                        else
                                echo "Invalid Column DataType. Only 'int' or 'string' are allowed."
                        fi
                done
                line+=":${ColType}"
                if [ "$flag" -eq 0 ]; then
                while true; do
                        read -p "Is it a primary key? (Y/N): " ColCon
                        if [[ "$ColCon" =~ ^[Yy]$ ]]; then
                                line+=":P"
                                flag=1
                                break
                        elif [[ "$ColCon" =~ ^[Nn]$ ]]; then
                                break
                        else
                                echo "Invalid input. Please enter Y for Yes or N for No."
                        fi
                done
                fi
                echo $line >> $TBMD
        done
        echo Table Created Successfully
fi
