#!/bin/bash
echo "List of Tables in " ${CurrDB} 
if [ -z "$(ls -A .)" ]; then
    echo "No tables found in the database."
else
        for table_file in ./*; do
                if [ -e $table_file ] && ! grep -q "MD" <<< "$(basename "$table_file")"; then
                        table_name=$(basename $table_file)
                        echo "- $table_name"
                fi
        done
fi
