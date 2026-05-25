#!/bin/bash
set -e

# Change to the directory containing this script.
# Exit if the directory change fails.
cd "$(dirname "${BASH_SOURCE[0]}")" || { echo "ERROR: Could not change to script directory." >&2; exit 1; }

# Check if python3 is available
if ! command -v python3 &> /dev/null
then
    echo "ERROR: python3 no está instalado en este agente de Jenkins." >&2
    echo "Asegúrate de que el PATH sea correcto o instala python3-venv." >&2
    exit 1
fi

# Check for uv and install if not present using the official installer
if ! command -v uv &> /dev/null
then
    echo "'uv' is not found. Attempting to install it using the official installer..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Add the default installation directory to the PATH for this script's execution
    export PATH="$HOME/.local/bin:$PATH"
fi

# Final check for uv
if ! command -v uv &> /dev/null
then
    echo "Failed to install or find 'uv'. Please install it manually from https://astral.sh/uv/install.sh and ensure it is in your PATH."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment with uv..."
    uv venv
fi

# Install dependencies
echo "Installing dependencies with uv..."
uv pip install -r requirements.txt

# Handle commands
if [ "$1" == "test" ]; then
    echo "Running tests with pytest..."
    ./.venv/bin/pytest
elif [ "$1" == "plan" ]; then
    echo "Ejecutando Terraform Plan..."
    terraform init
    terraform plan
elif [ "$1" == "apply" ]; then
    echo "Ejecutando Terraform Apply..."
    terraform apply -auto-approve
elif [ "$1" == "destroy" ]; then
    echo "Borrando toda la infraestructura para ahorrar dinero..."
    terraform init
    terraform destroy -auto-approve
else
    # Default behavior: Start the server
    echo "Starting Vertex AI server..."
    ./.venv/bin/python3 -m vertex.server
fi