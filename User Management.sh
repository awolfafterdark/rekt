#!/bin/bash

# Set variables
API_KEY="AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"
CLIENT_ID="568928957521-m57oil8lfnf2qlq6jnq4blp1ljcq4bc8.apps.googleusercontent.com"
ENDPOINT="https://us-central1-chatbot-e10c8.cloudfunctions.net"
TOKEN=""

# Function to generate a token using custom token
generate_token() {
  # Get custom token from input
  read -p "Enter custom token: " custom_token

  # Send API request to generate a token using custom token
  response=$(curl -s -X POST \
  "$ENDPOINT/generateToken" \
  -H "Content-Type: application/json" \
  --data '{"customToken":"'"$custom_token"'"}')

  # Extract token from response and store it in global variable
  TOKEN=$(echo $response | jq -r '.token')
}

# Function to create a new user
create_user() {
  # Get user details from input
  read -p "Enter user email: " email
  read -p "Enter user password: " password

  # Send API request to create a new user
  response=$(curl -s -X POST \
  "$ENDPOINT/createUser" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  --data '{"email":"'"$email"'","password":"'"$password"'"}')

  # Display response
  echo $response
}

# Function to update an existing user
update_user() {
  # Get user details from input
  read -p "Enter user email: " email
  read -p "Enter new password: " password

  # Send API request to update user
  response=$(curl -s -X PUT \
  "$ENDPOINT/updateUser" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  --data '{"email":"'"$email"'","password":"'"$password"'"}')

  # Display response
  echo $response
}

# Function to delete an existing user
delete_user() {
  # Get user email from input
  read -p "Enter user email: " email

  # Send API request to delete user
  response=$(curl -s -X DELETE \
  "$ENDPOINT/deleteUser" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  --data '{"email":"'"$email"'"}')

  # Display response
  echo $response
}

# Main function
main() {
  # Generate token using custom token
  generate_token

  # Display options for user management
  echo "Select an option:"
  echo "1. Create user"
  echo "2. Update user"
  echo "3. Delete user"
  read -p "Option: " option

  # Call appropriate function based on user's choice
  case $option in
    1)
      create_user
      ;;
    2)
      update_user
      ;;
    3)
      delete_user
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
}

# Call main function
main
