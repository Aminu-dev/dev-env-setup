#!/bin/bash

echo "Welcome to the development environment setup!"

if [ -f "./.env" ]; then

	source .env
	export APP_ENV DATABASE_NAME
	echo "Environment: $APP_ENV"
	echo "Database: $DATABASE_NAME"

else

	echo "ERROR: .env file not found."
	exit 1

fi

if command -v python3 >/dev/null 2>&1; then

	echo "Checking Python..."
	PYTHON_VERSION=$(python3 --version)
	echo "$PYTHON_VERSION detected."

else
	echo "ERROR: Python3 was not found"
	exit 1

fi

if command -v git >/dev/null 2>&1; then

	echo "Checking Git..."
	GIT_VERSION=$(git --version)
	echo "$GIT_VERSION detected."

else
	echo "ERROR: Git was not found"
	exit 1

fi

if [ -d "./source_code" ]; then

	echo -e "\nChecking source directory..."
	echo "Source directory already exists!"

else
	echo "Creating source directory"

	if mkdir ./source_code; then
		echo "Source directory created successfully..."
	else
		echo "ERROR: Could not create source directory."
		exit 1
	fi

fi

if [ -d "./source_code/.venv" ]; then

	echo "Virtual environment already exists."

else
	echo "Creating your Virtual environment"

	if python3 -m venv ./source_code/.venv; then
		echo "environment created successfully"
	else
		echo "ERROR: Could not create environment"
		exit 1
	fi

fi

if [ -f "./requirements.txt" ]; then

	echo "Checking if requirements are available"

	if ./source_code/.venv/bin/python -m pip install -r requirements.txt; then
		echo "Dependencies successfully installed"
	else
		echo "Something went wrong"
		exit 1
	fi

else
	echo "WARNING: requirements.txt not found. Skipping dependency installation."

fi


if [ -d "./source_code/Hello-World" ]; then

    echo "Repository already exists."

else
    echo "Repository not found. Cloning..."

    if git clone "https://github.com/octocat/Hello-World.git" ./source_code/Hello-World; then
    	echo "Git Repo cloned successfully!"
    else
    	echo "Repo failed to clone"
    	exit 1
    fi
    
fi


DATABASE_PATH="./source_code/${DATABASE_NAME}.sqlite3"

if [ -f "$DATABASE_PATH" ]; then

    echo "Database already exists."

else
    echo "Database does not exist. Creating..."

    if ./source_code/.venv/bin/python -c 'import sqlite3, sys; connection = sqlite3.connect(sys.argv[1]); connection.close()' "$DATABASE_PATH"; then

		echo "Database created"
	else
		echo "ERROR: Database creation failed."
    	exit 1
	fi

fi







