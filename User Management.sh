#!/bin/bash

# set variables

API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

BASE_URL="https://identitytoolkit.googleapis.com/v1/accounts"

ENDPOINT="/"

# function to create user

create_user() {

    read -p "Enter email address: " email

    read -p "Enter password: " password

    read -p "Enter display name: " displayName

    json="{\"email\":\"$email\",\"password\":\"$password\",\"displayName\":\"$displayName\",\"returnSecureToken\":true}"

    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json" "$BASE_URL:$ENDPOINT?key=$API_KEY")

    error=$(echo "$response" | jq -r '.error.message')

    if [ "$error" != "null" ]; then

        echo "Error: $error"

    else

        echo "User created successfully."

    fi

}

# function to get user info

get_user() {

    read -p "Enter user id: " userId

    response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"idToken\":\"$userId\"}" "$BASE_URL:lookup?key=$API_KEY")

    error=$(echo "$response" | jq -r '.error.message')

    if [ "$error" != "null" ]; then

        echo "Error: $error"

    else

        echo "$response"

    fi

}

# function to update user info

update_user() {

    read -p "Enter user id: " userId

    read -p "Enter new display name: " displayName

    json="{\"idToken\":\"$userId\",\"displayName\":\"$displayName\",\"returnSecureToken\":true}"

    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json" "$BASE_URL:update?key=$API_KEY")

    error=$(echo "$response" | jq -r '.error.message')

    if [ "$error" != "null" ]; then

        echo "Error: $error"

    else

        echo "User updated successfully."

    fi

}

# function to delete user

delete_user() {

    read -p "Enter user id: " userId

    json="{\"idToken\":\"$userId\"}"

    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json" "$BASE_URL:delete?key=$API_KEY")

    error=$(echo "$response" | jq -r '.error.message')

    if [ "$error" != "null" ]; then

        echo "Error: $error"

    else

        echo "User deleted successfully."

    fi

}

# main function

main() {

    echo "User Management Script"

    echo "1. Create User"

    echo "2. Get User Info"

    echo "3. Update User Info"

    echo "4. Delete User"

    read -p "Enter your choice (1-4): " choice

    case $choice in

        1) create_user ;;

        2) get_user ;;

        3) update_user ;;

        4) delete_user ;;

        *) echo "Invalid choice." ;;

    esac

}

main

