# Local Development Environment Setup Automation

## Overview

This project automates the setup of a local Python development environment using Bash.

The script checks for required tools, loads environment configuration, creates a Python virtual environment, installs dependencies, clones an example Git repository, and initializes a SQLite test database.

The goal is to reduce repetitive manual setup tasks and make the development environment easier to reproduce. A Dockerfile is included so the script can also be tested in a clean Ubuntu container.

## Features

- Checks whether Python 3 and Git are installed.
- Loads configuration from a local `.env` file and validates required variables.
- Creates a source directory when needed.
- Creates an isolated Python virtual environment.
- Installs Python dependencies from `requirements.txt`.
- Clones an example Git repository if it does not already exist.
- Creates a SQLite database file if it does not already exist.
- Recognizes existing resources on subsequent runs.
- Excludes local configuration and generated files from Git.

## Technologies

- Bash
- Python 3
- Git
- SQLite
- pip and Python virtual environments
- Docker

## Prerequisites

To run the script directly:

- macOS or a Debian-based Linux distribution such as Ubuntu (developed on macOS, also tested on Ubuntu in WSL 2)
- Bash
- Python 3 with `venv` support (on Ubuntu: `python3-venv`)
- Git
- Internet access for cloning the example repository and installing dependencies

To run it in Docker:

- Docker (Docker Desktop or Docker Engine)

## Configuration

Create a local `.env` file in the project root. The script exits with an error if the file is missing or if either variable below is not set.

```bash
APP_ENV=development
DATABASE_NAME=dev_test_db
```

| Variable | Purpose |
|---|---|
| `APP_ENV` | Name of the environment (for example `development`) |
| `DATABASE_NAME` | Name of the SQLite database file, without extension |

The `.env` file is intentionally excluded from version control.

## Usage

From the project root, run:

```bash
bash setup.sh
```

The script checks the environment and prepares the resources required for local development. Running it a second time skips anything that already exists.

## Run with Docker

The Dockerfile builds an Ubuntu 24.04 image with Python 3, Git, and the other tools the script needs. Running the container executes `setup.sh` in a clean environment, which shows that the script works on a machine that has never seen the project.

1. Create the `.env` file as described in Configuration.

2. Build the image:

   ```bash
   docker build -t dev-env-setup .
   ```

3. Run the container, mounting your `.env` file:

   ```bash
   docker run --rm -v "$PWD/.env:/app/.env:ro" dev-env-setup
   ```

Notes:

- `.env` is mounted at run time instead of being copied into the image, so your configuration stays out of the image.
- Everything the script creates (the virtual environment, the cloned repository, and the database file) lives inside the container. It is deleted when the container is removed, which `--rm` does automatically.
- Each run starts from scratch, so dependencies are downloaded and the example repository is cloned every time.

## Dependencies

Python dependencies are listed in `requirements.txt` and installed into the project's virtual environment. If `requirements.txt` is missing, the script prints a warning and skips the installation.

## Database

The setup script creates an empty SQLite database file under `source_code/`, named `<DATABASE_NAME>.sqlite3`, using the name specified in `.env`.

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
- Git exclusion of local and generated files
- A full run in a clean Ubuntu 24.04 Docker container

## Security and Version Control

The `.env` file, virtual environment, generated database, and cloned example repository are excluded through `.gitignore`.

Only the files needed to describe and reproduce the setup process should be tracked in the project's repository.

## Future Improvements

- Add more comprehensive failure-handling tests.
- Improve input validation and configuration checks.
- Allow the example repository URL to be configured.
- Add clearer logging and setup summaries.
- Install dependencies at image build time so container runs are faster.
- Add a GitHub Actions workflow that builds the image and runs the script automatically.