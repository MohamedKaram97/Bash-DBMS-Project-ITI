#!/bin/bash
echo "Available Databases:"
for db in ./*;
do
        db="${db/"./"/}"
        echo $db
done
