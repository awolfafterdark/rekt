import requests

import json

# Ask for new username and password

new_username = input("Enter a new username: ")

new_password = input("Enter a new password: ")

# Set up the request parameters

url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCm99fk0vDQlgXMgTM9fzlqXiQWHpdOMKA"

headers = {"Content-Type": "application/json"}

data = {

    "email": new_username,

    "password": new_password,

    "returnSecureToken": True

}

# Send the HTTP POST request to create a new user

response = requests.post(url, headers=headers, data=json.dumps(data))

# Check if the request was successful

if response.status_code == 200:

    print("User", new_username, "created successfully!")

else:

    print("Error creating user:", response.json()["error"]["message"])

