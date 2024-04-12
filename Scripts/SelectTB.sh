#!/bin/bash
function AllFunc(){
        echo Select the column you want to make condition on it or none or exit 
        arr=($(awk -F: '{print $1}' "${TB}MD"))
        echo ${arr[@]} "none" "exit"
        found=false
        while ! $found; do
                read -p "Enter your choice : " col

                for item in "${arr[@]}" "none"; do
                        if [ "$col" == "$item" ]; then
                                found=true
                                if [ "$col" == "none" ]; then
                                        echo Your selected rows are : 
                                        cat $TB
                                else
                                        read -p "Enter Your Condition : " cond
                                        row_number=$(awk -F: -v search="$col" '$1 == search {print NR}' "${TB}MD")
                                        echo Your selected row are : 
                                        awk -F: -v col_num="$row_number" -v cond="$cond" '{ if ($col_num==cond) print }' "$TB"
                                fi
                                break
                        fi
                done
                if [ "$col" == "exit" ]; then
                        echo Backing To Table Menu
                        break
                fi
                if ! $found; then
                        echo Invalid Choice
                fi
        done
}
function ByColumnFunc(){
        echo Select column name from these columns or exit
        arr=($(awk -F: '{print $1}' "${TB}MD"))
        echo ${arr[@]}
        flag=false
        while true; do
                read -p "Enter Column Name : " colname
                for coln in "${arr[@]}"; do
                        if [ "$colname" == "$coln" ]; then
                                flag=true
                                echo Select the column you want to make condition on it or none or exit 
                                arr2=($(awk -F: '{print $1}' "${TB}MD"))
                                echo ${arr2[@]} "none" "exit"
                                found=false
                                while ! $found; do
                                        read -p "Enter Column : " col
                                        for item in "${arr2[@]}" "none"; do
                                                if [ "$col" == "$item" ]; then
                                                        found=true
                                                        if [ "$col" == "none" ]; then
                                                                col_number=$(awk -F: -v search="$colname" '$1 == search {print NR}' "${TB}MD")
                                                                awk -F: -v col_num="$col_number" '{print $col_num }' "$TB"
                                                        else
                                                                read -p "Enter Your Condition : " cond
                                                                col_number=$(awk -F: -v search="$colname" '$1 == search {print NR}' "${TB}MD")
                                                                row_number=$(awk -F: -v search="$col" '$1 == search {print NR}' "${TB}MD")
                                                                awk -F: -v col_num="$row_number" -v cond="$cond" -v col_numb="$col_number" '{ if ($col_num==cond) print $col_numb}' "$TB"
                                                        fi
                                                        break
                                                fi
                                        done
                                        if [ "$col" == "exit" ]; then
                                                echo Backing To Table Menu
                                                break
                                        fi

                                        if ! $found; then
                                                echo Invalid Choice
                                        fi
                                done
                                break
                        fi
                done
		if [ "$colname" == "exit" ]; then
                        echo Backing To Table Menu
                        break
                fi
                if ! $flag; then
                        echo Invalid Column
                else
                        break
                fi
        done

}
read -p "Enter Table Name : " TB

if [ -z "$TB" ]; then
        echo "Please Enter Table Name"
elif [ ! -e "$TB" ]; then
        echo "Table Does Not Exist"
else
        select option in All ByColumn Exit
        do
        if [ -n "$option" ]; then
                case $option in
                        "All")          AllFunc
                                        break
                                        ;;
                        "ByColumn")     ByColumnFunc
                                        break
                                        ;;
                        "Exit")         echo Backing to Table Menu
                                        break
                                        ;;

                                *)      echo Invalid Option
                                        ;;
                esac
        else
                echo Invalid Option
        fi
done
fi
