#!/bin/bash
echo ------------ DataBases Menu --------------
if [ -d DataBases ]; then
        cd DataBases
        select option in CreateDB ListDB ConnectDB DropDB Exit
        do
        if [ -n "$option" ]; then
                case $option in
                        "CreateDB") . .././CreateDB.sh
                                ;;
                        "ListDB") . .././ListDB.sh
                                ;;
                        "ConnectDB") . .././ConnectDB.sh
                                ;;
                        "DropDB") . .././DropDB.sh
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
else
        mkdir  DataBases
        cd DataBases
        select option in CreateDB ListDB ConnectDB DropDB Exit
        do
        if [ -n "$option" ]; then
                case $option in
                        "CreateDB") . .././CreateDB.sh
                                ;;
                        "ListDB") . .././ListDB.sh
                                ;;
                        "ConnectDB") . .././ConnectDB.sh
                                ;;
                        "DropDB") . .././DropDB.sh
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

fi

