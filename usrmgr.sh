#!/bin/bash

# Firebase credentials

CLIENT_ID="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"

API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

# Chatbot endpoint

ENDPOINT="us-central1-chatbot-e10c8.cloudfunctions.net/chatbot"

# Generate a new token

TOKEN=$(curl -s -X POST "https://$ENDPOINT" -H "Authorization: Bearer $API_KEY" -H "Content-Type: application/json" -d '{"client_id":"'$CLIENT_ID'", "offline": true}' | jq -r '.["firebase_access_token"]')

echo "Select an option:"

echo "1. Create a new user"

echo "2. Delete a user"

echo "3. Get user details"

read option

case $option in

  1)

    echo "Enter user email:"

    read email

    echo "Enter user password:"

    read password

    curl -s -X POST "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY" -H "Content-Type: application/json" --data-binary '{"email":"'$email'", "password":"'$password'", "returnSecureToken":true}' | jq .

    ;;

  2)

    echo "Enter user id:"

    read userId

    curl -s -X POST "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$API_KEY" -H "Content-Type: application/json" --data-binary '{"localId":"'$userId'", "idToken":"'$TOKEN'"}' | jq .

    ;;

  3)

    echo "Enter user id:"

    read userId

    curl -s -X POST "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$API_KEY" -H "Content-Type: application/json" --data-binary '{"localId":"'$userId'", "idToken":"'$TOKEN'"}' | jq .

    ;;

  *)

    echo "Invalid option selected."

    ;;

esac

