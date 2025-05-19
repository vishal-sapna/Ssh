#!/bin/bash

clear
echo "========================================"
echo "        USERNAME CHANGE UTILITY         "
echo "========================================"
echo
echo " [1] Start Username Change"
echo " [0] Exit"
echo
read -p "Enter your choice: " choice

if [ "$choice" = "1" ]; then
    read -p "Enter OLD username: " old_user
    read -p "Enter NEW username: " new_user

    if [ "$(id -u)" -ne 0 ]; then
        echo "[ERROR] This script must be run as root."
        exit 1
    fi

    if ! id "$old_user" &>/dev/null; then
        echo "[ERROR] User '$old_user' does not exist."
        exit 1
    fi

    if id "$new_user" &>/dev/null; then
        echo "[ERROR] User '$new_user' already exists."
        exit 1
    fi

    echo "[INFO] Killing all processes of $old_user..."
    pkill -u "$old_user"

    echo "[INFO] Renaming user..."
    usermod -l "$new_user" "$old_user"

    echo "[INFO] Renaming group..."
    groupmod -n "$new_user" "$old_user"

    echo "[INFO] Renaming home directory..."
    usermod -d /home/"$new_user" -m "$new_user"

    echo "[INFO] Changing ownership..."
    chown -R "$new_user":"$new_user" /home/"$new_user"

    echo
    echo "[SUCCESS] Username changed from $old_user to $new_user successfully."
    echo

elif [ "$choice" = "0" ]; then
    echo "Exiting..."
    exit 0
else
    echo "Invalid choice. Please try again."
    exit 1
fi
