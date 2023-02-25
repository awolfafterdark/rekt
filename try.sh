#!/bin/bash

# Firebase credentials

CLIENT_ID="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"

API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

# Chatbot endpoint

ENDPOINT="us-central1-chatbot-e10c8.cloudfunctions.net/chatbot"

# Generate a new token

# Fill in your Firebase Offline Token Gen data here

client_id="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"

gcm_sender_id="568928957521"

project_id="aichat-4fb19"

api_key="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

# Generate a token

now=$(date +%s)

exp_seconds=3600 # Token valid for 1 hour

exp_time=$((now+exp_seconds))

# Create the token payload

payload='{

    "iss": "'$client_id'",

    "sub": "'$client_id'",

    "aud": "https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit",

    "iat": '$now',

    "exp": '$exp_time',

    "uid": "1",

    "claims": {

        "kid": "p256",

        "alg": "RS256",

        "typ": "JWT"

    }

}'

# Sign the token using the API key

TOKEN1=$(echo -n "$payload" | openssl dgst -sha256 -binary -hmac "$api_key" | openssl base64 -A)

# Get the new token

AUTHTOKEN=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"token\":\"$TOKEN1\",\"returnSecureToken\":true}" "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=$API_KEY" | jq -r '.idToken')

echo "Generated token: $AUTHTOKEN"

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

    curl -s -X POST "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$API_KEY" -H "Content-Type: application/json" --data-binary '{"localId":"'$userId'", "idToken":"'$AUTHTOKEN'"}' | jq .

    ;;

  3)

    echo "Enter user id:"

    read userId

    curl -s -X POST "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$API_KEY" -H "Content-Type: application/json" --data-binary '{"localId":"'$userId'", "idToken":"'$AUTHTOKEN'"}' | jq .

    ;;

  *)

    echo "Invalid option selected."

    ;;

esac

