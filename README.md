# Local Development Environment Setup Automation

## Overview

This project automates the setup of a local Python development environment using Bash.

The script checks for required tools, loads environment configuration, creates a Python virtual environment, installs dependencies, clones an example Git repository, and initializes a SQLite test database.

The goal is to reduce repetitive manual setup tasks and make the development environment easier to reproduce.

## Features

- Checks whether Python 3 and Git are installed.
- Loads configuration from a local `.env` file.
- Creates a source directory when needed.
- Creates an isolated Python virtual environment.
- Installs Python dependencies from `requirements.txt`.
- Clones an example Git repository if it does not already exist.
- Creates a SQLite database if it does not already exist.
- Recognizes existing resources on subsequent runs.
- Excludes local configuration and generated files from Git.

## Technologies

- Bash
- Python 3
- Git
- SQLite
- pip
- Python virtual environments

## Prerequisites

- macOS or another compatible Unix-like environment
- Bash
- Python 3 with virtual environment support
- Git
- Internet access for cloning the example repository and installing dependencies

## Configuration

Create a local `.env` file in the project root:

```bash
APP_ENV=development
DATABASE_NAME=dev_test_db
```

The `.env` file is intentionally excluded from version control.

## Usage

From the project root, run:

```bash
bash setup.sh
```

The script checks the environment and prepares the resources required for local development.

## Dependencies

Python dependencies are listed in `requirements.txt` and installed into the project's virtual environment.

## Database

The setup script creates a local SQLite database under `source_code/` using the database name specified in `.env`.

The database file is generated locally and excluded from version control.

## Testing

The project was tested for:

- Python and Git detection
- Environment variable loading
- Virtual environment creation
- Dependency installation
- Git repository cloning
- Existing repository detection
- SQLite database creation
- Existing database detection
- Database integrity verification
- Git exclusion of local and generated files

## Security and Version Control

The `.env` file, virtual environment, generated database, and cloned example repository are excluded through `.gitignore`.

Only the files needed to describe and reproduce the setup process should be tracked in the project's repository.

## Future Improvements

- Add more comprehensive failure-handling tests.
- Improve input validation and configuration checks.
- Allow the example repository URL to be configured.
- Add clearer logging and setup summaries.
- Explore automated testing and continuous integration.
