#!/bin/bash
echo ------------- Tables Menu ---------------
select option in CreateTable ListTable DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable Exit
do
if [ -n "$option" ]; then
        case $option in
                "CreateTable") . ../.././CreateTB.sh
                        ;;
                "ListTable") . ../.././ListTB.sh
                        ;;
                "DropTable") . ../.././DropTB.sh
                        ;;
                "InsertIntoTable") . ../.././InsertTB.sh
                        ;;
                "SelectFromTable") . ../.././SelectTB.sh
                        ;;
                "DeleteFromTable") . ../.././DeleteTB.sh
                        ;;
                "UpdateTable") . ../.././UpdateTB.sh
                        ;;
                "Exit") break;
                        ;;
                *) echo Invalid Option
                        ;;
        esac
else
        echo Invalid Option
fi
done
cd ../..
. ./main.sh
