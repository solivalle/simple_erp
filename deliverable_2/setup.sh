#!/usr/bin/env bash

set -e

echo "Starting project setup..."

# -----------------------
# Check Python
# -----------------------

if ! command -v python3 &> /dev/null
then
    echo "ERROR: Python3 is not installed."
    exit 1
fi

PY_VERSION=$(python3 -c 'import sys; print(sys.version_info[:2])')

echo "Python detected."

# -----------------------
# Create virtualenv
# -----------------------

if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate

# -----------------------
# Install dependencies
# -----------------------

echo "Installing dependencies..."

pip install --upgrade pip
pip install -r requirements.txt

# -----------------------
# Check PostgreSQL
# -----------------------

if ! command -v psql &> /dev/null
then
    echo "WARNING: PostgreSQL client not found."
    echo "Make sure PostgreSQL server is installed."
fi

# -----------------------
# Setup environment file
# -----------------------

if [ ! -f ".env" ]; then
    echo "Creating .env file..."
    cp .env.example .env
fi

# -----------------------
# Run migrations
# -----------------------

echo "Running migrations..."

python manage.py migrate

echo "Setup completed successfully."

echo "Run the server with:"
echo "source venv/bin/activate && python manage.py runserver"