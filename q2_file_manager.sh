#!/bin/bash

# fcmodile_manager.sh
# This script provides a menu-driven file and directory manager

while true
do
    echo "1. Create File"
    echo "2. Create Directory"
    echo "3. Delete File"
    echo "4. Delete Directory"
    echo "5. List Files and Directories"
    echo "6. Search for a File"
    echo "7. Count Files and Directories"
    echo "8. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in

        1)
            echo "Enter file name:"
            read fname
            touch "$fname"
            echo "File created successfully."
            ;;

        2)
            echo "Enter directory name:"
            read dname
            mkdir "$dname"
            echo "Directory created successfully."
            ;;

        3)
            echo "Enter file name to delete:"
            read fname
            rm -f "$fname"
            echo "File deleted."
            ;;

        4)
            echo "Enter directory name to delete:"
            read dname
            rm -r "$dname"
            echo "Directory deleted."
            ;;

        5)
            echo "Listing Files and Directories:"
            ls -l
            ;;

        6)
            echo "Enter file name to search:"
            read searchfile
            find . -name "$searchfile"
            ;;

        7)
            echo "Counting files and directories..."
            
            FILE_COUNT=$(find . -type f | wc -l)
            DIR_COUNT=$(find . -type d | wc -l)

            echo "Total Files: $FILE_COUNT"
            echo "Total Directories: $DIR_COUNT"
            ;;

        8)
            echo "Exiting File Manager..."
            break
            ;;

        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    echo ""
done