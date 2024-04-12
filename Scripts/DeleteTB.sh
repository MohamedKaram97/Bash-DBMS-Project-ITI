#!/bin/bash
read -p "Enter Table Name : " TB

if [ -z "$TB" ]; then
        echo "Please Enter Table Name"
elif [ ! -e "$TB" ]; then
        echo "Table Does Not Exist"
else
        echo Enter the conditioned column or None 
        arr=($(awk -F: '{print $1}' "${TB}MD"))
        echo ${arr[@]} "None Exit"
        found=false
        while ! $found; do
                read -p "Enter your choice : " col

                for item in "${arr[@]}" "None"; do
                        if [ "$col" == "$item" ]; then
                                found=true
                                if [ "$col" == "None" ]; then
                                        : > "$TB"
                                        echo "Content of $TB deleted."
                                else
                                        read -p "Enter your condition : " cond
                                        row_number=$(awk -F: -v search="$col" '$1 == search {print NR}' "${TB}MD")
                                        awk -F: -v col_num="$row_number" -v cond="$cond" '{ if ($col_num != cond) print }' "$TB" > "$TB.tmp" && mv "$TB.tmp" "$TB"
                                        echo "Rows matching condition deleted."
                                fi
                                break
                        fi
                done
                if [  $col=="Exit" ]; then
                        break
                fi
                if ! $found; then
                        echo Invalid Choice
                fi
        done
fi
