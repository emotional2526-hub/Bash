#!/bin/bash

# fcmodile_manager.sh
# This script provides a menu-driven file and directory manager

while true
do
    echo "===== FILE MANAGER MENU ====="
    echo "1. Create File"
    echo "2. Create Directory"
    echo "3. Delete File"
    echo "4. Delete Directory"
    echo "5. List Files"
    echo "6. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1)
            echo "Enter file name:"
            read fname
            touch $fname
            echo "File created successfully."
            ;;
        2)
            echo "Enter directory name:"
            read dname
            mkdir $dname
            echo "Directory created successfully."
            ;;
        3)
            echo "Enter file name to delete:"
            read fname
            rm -f $fname
            echo "File deleted."
            ;;
        4)
            echo "Enter directory name to delete:"
            read dname
            rm -r $dname
            echo "Directory deleted."
            ;;
        5)
            echo "Files and Directories:"
            ls -l
            ;;
        6)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Try again."
            ;;
    esac
done