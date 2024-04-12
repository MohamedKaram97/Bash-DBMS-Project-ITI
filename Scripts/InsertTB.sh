#!/bin/bash
read -p "Enter Table Name : " TB

if [ -z "$TB" ]; then
    echo "Please Enter Table Name"
elif [ ! -e "$TB" ]; then
    echo "Table Does Not Exist"
else
        line=""
        Cols=$(wc -l < ${TB}MD)
        for ((i=1;i<=$Cols;i++))
        do
                colname=$(awk -v i="$i" 'BEGIN{FS=":"}{ if (NR==i) print $1}' "${TB}MD")
                coltype=$(awk -v i="$i" 'BEGIN{FS=":"}{ if (NR==i) print $2}' "${TB}MD")
                colcon=$(awk -v i="$i" 'BEGIN{FS=":"}{ if (NR==i) print $3}' "${TB}MD")
                while true; do
                        read -p "Enter your ${colname} : " value
                        if [ -z "$value" ]; then
                                echo Please Enter your ${colname}
                        elif [[ "$coltype" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
                                echo Invalid Type. Expected Type ${coltype}                     
                        elif [[ "$coltype" == "string" && ! "$value" =~ ^[a-zA-Z0-9]+$ ]]; then
                                echo Invalid Type. Expected Type ${coltype}
                        else
                                if [ "$colcon" == "P" ]; then
                                        if awk -F: -v value="$value" -v col="$i" '$col == value' "$TB" | grep -q .; then
                                                echo "Value already exists in the column '$colname'"
                                        else
                                                break
                                        fi
                                else
                                        break
                                fi
                        fi

                done
                if [ "$i" == "$Cols" ]; then
                        line+="$value"
                else
                        line+="$value:"
                fi
        done
                echo $line >> $TB
		echo Inserted Successfully

fi