# Development Scripts Collection

A collection of useful scripts for development operations.

## Available Scripts

### gitignore

A command-line tool for downloading `.gitignore` templates from GitHub's official gitignore repository.

**Features:**

- Download gitignore templates for 50+ programming languages
- Append to existing .gitignore files with proper section headers
- Print to stdout for custom workflows
- Smart language name matching with common aliases
- Color-coded status messages

## Installation

### Quick Install

```bash
# Clone the repository
git clone <repository-url> ~/developer/scripts
cd ~/developer/scripts

# Run the installation script
./install.sh
```

### Manual Install

If you prefer not to use sudo or want more control:

```bash
# Option 1: Add to PATH
echo 'export PATH="$PATH:~/developer/scripts"' >> ~/.bashrc
source ~/.bashrc

# Option 2: Create alias
echo 'alias gitignore="~/developer/scripts/gitignore.sh"' >> ~/.bashrc
source ~/.bashrc

# Option 3: Symlink to user's local bin (no sudo required)
mkdir -p ~/.local/bin
ln -s ~/developer/scripts/gitignore.sh ~/.local/bin/gitignore
# Make sure ~/.local/bin is in your PATH
```

## Usage

### gitignore

```bash
# Download Python gitignore (overwrites existing)
gitignore python

# Append Node.js gitignore to existing file
gitignore -a node

# Print Ruby gitignore to stdout
gitignore -p ruby

# Save to custom location
gitignore --stdout go > custom.gitignore

# Multiple languages
gitignore python && gitignore -a javascript
```

See [gitignore/README.md](gitignore/README.md) for detailed documentation.

## Uninstallation

To remove the installed scripts:

```bash
./uninstall.sh
```

Or manually:

```bash
rm -f /usr/local/bin/gitignore
```

## About Installation Practices

The current `install.sh` uses `sudo` to create a symlink in `/usr/local/bin/`. While this works, here are some considerations:

**Pros:**

- Simple one-line installation
- Makes the script globally available
- Standard location for user-installed binaries

**Cons:**

- Requires sudo privileges
- Uses relative path (breaks if repository moves)
- No error handling or permission checks
- No option for user-specific installation

**Recommended improvements:**

1. Check for permissions before attempting installation
2. Use absolute paths for the symlink
3. Offer user-specific installation option (`~/.local/bin/`)
4. Add error handling and informative messages
5. Check if commands already exist before installing

## Contributing

Feel free to add more useful scripts to this collection. Each script should:

- Have a clear, single purpose
- Include help documentation (`-h` or `--help`)
- Follow consistent coding style
- Include examples in its documentation

## License

[Add your license here]
