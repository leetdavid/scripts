#!/bin/bash

# Installation script for development scripts collection

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Installing development scripts...${NC}\n"

# Function to create symlink with proper error handling
install_script() {
    local script_name=$1
    local script_path=$2
    local install_dir=$3
    
    if [ -L "$install_dir/$script_name" ] || [ -f "$install_dir/$script_name" ]; then
        echo -e "${YELLOW}!${NC} $script_name already exists in $install_dir"
        read -p "    Overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "    Skipping $script_name"
            return
        fi
        rm -f "$install_dir/$script_name"
    fi
    
    ln -s "$script_path" "$install_dir/$script_name"
    echo -e "${GREEN}✓${NC} Installed $script_name to $install_dir"
}

# Check if we should install system-wide or user-local
if [ "$1" == "--user" ] || [ ! -w /usr/local/bin ]; then
    # User installation
    INSTALL_DIR="$HOME/.local/bin"
    echo "Installing to user directory: $INSTALL_DIR"
    
    # Create user bin directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo -e "\n${YELLOW}Note:${NC} $INSTALL_DIR is not in your PATH"
        echo "Add the following to your ~/.bashrc or ~/.zshrc:"
        echo -e "${BLUE}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    fi
else
    # System-wide installation
    INSTALL_DIR="/usr/local/bin"
    echo "Installing system-wide to: $INSTALL_DIR"
    
    if [ "$EUID" -ne 0 ] && [ ! -w "$INSTALL_DIR" ]; then
        echo -e "${RED}Error:${NC} This script needs write permission to $INSTALL_DIR"
        echo "Please run with sudo or use --user flag for user installation:"
        echo "  sudo $0"
        echo "  $0 --user"
        exit 1
    fi
fi

echo

# Install gitignore script
if [ -f "$SCRIPT_DIR/gitignore.sh" ]; then
    install_script "gitignore" "$SCRIPT_DIR/gitignore.sh" "$INSTALL_DIR"
else
    echo -e "${RED}Error:${NC} gitignore.sh not found in $SCRIPT_DIR"
    exit 1
fi

# Future scripts can be added here
# install_script "another-script" "$SCRIPT_DIR/another-script.sh" "$INSTALL_DIR"

echo -e "\n${GREEN}Installation complete!${NC}"
echo "You can now use: gitignore <language>"
echo "For help, run: gitignore -h"