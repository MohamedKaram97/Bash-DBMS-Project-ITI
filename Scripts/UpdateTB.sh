#!/bin/bash
read -p "Enter Table Name : " TB

if [ -z "$TB" ]; then
    echo "Please Enter Table Name"
elif [ ! -e "$TB" ]; then
    echo "Table Does Not Exist"
else
        echo Enter column name you want to update from these columns or exit 
        arr=($(awk -F: '{print $1}' "${TB}MD"))
        echo ${arr[@]} "exit"
        flag=false
        while true; do
                read -p "Enter Column Name : " colname
                for coln in "${arr[@]}"; do
                        if [ "$colname" == "$coln" ]; then
                                flag=true
                                coltype=$(awk -F: -v search="$colname" '$1 == search {print $2}' "${TB}MD")
                                colcon=$(awk -F: -v search="$colname" '$1 == search {print $3}' "${TB}MD")
				col_=$(awk -F: -v search="$colname" '$1 == search {print NR}' "${TB}MD")
                                while true; do
                                        read -p "Enter your new ${colname} : " value
                                        if [ -z "$value" ]; then
                                                echo Please enter your new ${colname}
                                        elif [[ "$coltype" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
                                                echo Invalid Type. Expected Type ${coltype}                     
                                        elif [[ "$coltype" == "string" && ! "$value" =~ ^[a-zA-Z0-9]+$ ]]; then
                                                echo Invalid Type. Expected Type ${coltype}
					elif [[ "$colcon" == "P" ]]; then
						if awk -F: -v value="$value" -v col="$col_" '$col == value' "$TB" | grep -q .; then
                                                	echo "This is a primary key col and value already exists in that column '$colname'"
						else
							break
						fi
                                        else
                                                break
                                        fi

                                done
                                echo Enter the column you want to make condition on it
                                arr2=($(awk -F: '{print $1}' "${TB}MD"))
                                echo ${arr2[@]} "None"
                                found=false
                                while ! $found; do
                                        read -p "Enter Column : " col
                                        for item in "${arr2[@]}" "None"; do
                                                if [ "$col" == "$item" ]; then
                                                        found=true
                                                        if [ "$col" == "None" ]; then
                                                                col_number=$(awk -F: -v search="$colname" '$1 == search {print NR}' "${TB}MD")
								awk -F: -v col_num="$col_number" -v new_val="$value" 'BEGIN {OFS=":"} {$col_num=new_val} 1' "$TB" > temp && mv temp "$TB"
                                                                echo Updated Successfully
                                                        else
                                                                read -p "Enter Your Condition : " cond
                                                                col_number=$(awk -F: -v search="$colname" '$1 == search {print NR}' "${TB}MD")
                                                                row_number=$(awk -F: -v search="$col" '$1 == search {print NR}' "${TB}MD")
awk -F: -v col_num="$row_number" -v cond="$cond" -v col_numb="$col_number" -v new_val="$value" 'BEGIN {OFS=":"} { if ($col_num==cond) $col_numb=new_val} 1' "$TB" > temp && mv temp "$TB"
                                                                echo Updated Successfully
                                                        fi
                                                        break
                                                fi
                                        done
                                        if ! $found; then
                                                echo Invalid Choice
                                        fi
                                done
                                break
                        fi
                done
                if [  "$colname" == "exit" ]; then
                        echo Backing To Table Menu
                        break
                fi
                if ! $flag; then
                        echo Invalid Column
                else
                        break
                fi
        done
fi

