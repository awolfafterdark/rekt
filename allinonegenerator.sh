#!/bin/bash

# Set variables for Firebase project

CLIENT_ID="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"

REVERSED_CLIENT_ID="com.googleusercontent.apps.568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8"

API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

GCM_SENDER_ID="568928957521"

BUNDLE_ID="com.pb.chatgptmac"

PROJECT_ID="aichat-4fb19"

STORAGE_BUCKET="aichat-4fb19.appspot.com"

GOOGLE_APP_ID="1:568928957521:ios:14ccbf85a464137f73f470"

# Ask user for task to complete

echo "What task do you want to complete?"

echo "1. Generate Firebase offline token"

echo "2. Retrieve data from Firestore"

echo "3. Add data to Firestore"

read -p "Enter task number: " TASK

# Perform task based on user input

if [ "$TASK" == "1" ]; then

  # Generate Firebase offline token

  URL="https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=$API_KEY"

  read -p "Enter UID for the token: " UID

  read -p "Enter the path to the private key file: " KEYFILE

  TOKEN=$(curl -s $URL \

    -H "Content-Type: application/json" \

    -d "{\"token\":\"$(cat $KEYFILE)\",\"returnSecureToken\":true,\"requestUri\":\"$BUNDLE_ID\"}" | jq -r .idToken)

  echo "Firebase offline token generated: $TOKEN"

elif [ "$TASK" == "2" ]; then

  # Retrieve data from Firestore

  read -p "Enter collection name: " COLLECTION

  read -p "Enter document ID: " DOC_ID

  URL="https://firestore.googleapis.com/v1/projects/$PROJECT_ID/databases/(default)/documents/$COLLECTION/$DOC_ID?key=$API_KEY"

  DATA=$(curl -s $URL)

  echo "Retrieved data: $DATA"

elif [ "$TASK" == "3" ]; then

  # Add data to Firestore

  read -p "Enter collection name: " COLLECTION

  read -p "Enter document ID: " DOC_ID

  read -p "Enter data to add (in JSON format): " NEW_DATA

  URL="https://firestore.googleapis.com/v1/projects/$PROJECT_ID/databases/(default)/documents/$COLLECTION/$DOC_ID?key=$API_KEY"

  RESULT=$(curl -s -X PATCH $URL \

    -H "Content-Type: application/json" \

    -d "{\"fields\": $NEW_DATA}")

  echo "Data added: $RESULT"

else

  echo "Invalid task number"

fi

