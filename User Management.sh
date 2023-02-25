#!/bin/bash

# Set required credentials

CLIENT_ID="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"

REVERSED_CLIENT_ID="com.googleusercontent.apps.568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8"

API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

GCM_SENDER_ID="568928957521"

BUNDLE_ID="com.pb.chatgptmac"

PROJECT_ID="aichat-4fb19"

STORAGE_BUCKET="aichat-4fb19.appspot.com"

GOOGLE_APP_ID="1:568928957521:ios:14ccbf85a464137f73f470"

# Generate a new Firebase authentication token

echo "Generating Firebase authentication token..."

FIREBASE_TOKEN=$(curl "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=$API_KEY" \

  -H "Content-Type: application/json" \

  --data-binary "{\"token\":\"$(curl -s -X POST \

                                -H 'Content-Type: application/json' \

                                -H 'Accept: */*' \

                                -H 'Accept-Encoding: gzip, deflate' \

                                -H 'User-Agent: Chat%20Bot/3.2' \

                                -H 'Content-Length: 51' \

                                -H 'Accept-Language: en-US,en;q=0.9' \

                                -d '{\"message\": \"Hello\"}' \

                                https://us-central1-chatbot-e10c8.cloudfunctions.net/chatbot \

                                -w '\n%{http_code}')\",\"returnSecureToken\":true}" \

  -s | jq -r '.idToken')

# Prompt user to select a task

echo "Select a user management task to perform:"

echo "1. Create user"

echo "2. Update user"

echo "3. Delete user"

read -p "Enter a number: " task

case $task in

  1)

    # Create user

    read -p "Enter email address: " email

    read -p "Enter password: " password

    read -p "Enter display name: " displayName

    echo "Creating user..."

    curl "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY" \

      -H "Content-Type: application/json" \

      -d "{\"email\":\"$email\",\"password\":\"$password\",\"displayName\":\"$displayName\",\"returnSecureToken\":true,\"localId\":\"$PROJECT_ID\"}" \

      -H "Authorization: Bearer $FIREBASE_TOKEN"

    ;;

  2)

    # Update user

    read -p "Enter user ID: " userId

    read -p "Enter new display name: " displayName

    echo "Updating user..."

    curl "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$API_KEY" \

      -H "Content-Type: application/json" \

      -d "{\"localId\":\"$userId\",\"displayName\":\"$displayName\",\"idToken\":\"$FIREBASE_TOKEN\"}"

    ;;

  3)

    # Delete user

    read -p "Enter user ID: " userId

    echo "Deleting user..."

    curl "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$API_KEY" \

      -H "Content-Type: application/json" \

      -d "{\"localId\":\"$
