#!/bin/bash

# Uninstall script for development scripts collection

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Uninstalling development scripts..."

# Check if running with appropriate permissions
if [ -w /usr/local/bin ]; then
    # Remove gitignore symlink
    if [ -L /usr/local/bin/gitignore ]; then
        rm -f /usr/local/bin/gitignore
        echo -e "${GREEN}✓${NC} Removed gitignore from /usr/local/bin/"
    else
        echo -e "${YELLOW}!${NC} gitignore not found in /usr/local/bin/"
    fi
else
    echo -e "${YELLOW}!${NC} No write permission to /usr/local/bin/"
    echo "    Checking user locations..."
fi

# Check user-specific locations
if [ -L ~/.local/bin/gitignore ]; then
    rm -f ~/.local/bin/gitignore
    echo -e "${GREEN}✓${NC} Removed gitignore from ~/.local/bin/"
fi

# Check for aliases in common shell configs
for config in ~/.bashrc ~/.zshrc ~/.bash_profile; do
    if [ -f "$config" ] && grep -q "alias gitignore=" "$config"; then
        echo -e "${YELLOW}!${NC} Found gitignore alias in $config"
        echo "    Please remove manually or run:"
        echo "    sed -i '/alias gitignore=/d' $config"
    fi
done

# Check PATH modifications
for config in ~/.bashrc ~/.zshrc ~/.bash_profile; do
    if [ -f "$config" ] && grep -q "developer/scripts" "$config"; then
        echo -e "${YELLOW}!${NC} Found PATH modification in $config"
        echo "    Please remove manually or run:"
        echo "    sed -i '/developer\/scripts/d' $config"
    fi
done

echo -e "\n${GREEN}Uninstallation complete!${NC}"
echo "Repository files remain at: $(pwd)"
echo "To completely remove, delete this directory."