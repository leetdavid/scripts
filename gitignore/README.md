# GitIgnore Downloader Script

A shell script to download `.gitignore` files from GitHub's official gitignore repository.

## Usage

```bash
./gitignore.sh [options] <language>
```

## Default Behavior

By default, the script downloads the gitignore template directly to `.gitignore` file:

```bash
# Download Python gitignore to .gitignore (overwrites existing)
./gitignore.sh python

# Download C++ gitignore (case-insensitive)
./gitignore.sh C++
```

## Options

- `-p`, `--print`, `--stdout` - Print to stdout instead of writing to file
- `-a`, `--append` - Append to existing .gitignore instead of overwriting
- `-h`, `--help` - Show help message

## Examples

### Basic Usage (saves to .gitignore)
```bash
# Download Python gitignore to .gitignore
./gitignore.sh python

# Append Node.js gitignore to existing .gitignore
./gitignore.sh -a node
```

### Print to stdout
```bash
# Print Python gitignore to stdout
./gitignore.sh -p python

# Redirect to custom file
./gitignore.sh --stdout ruby > my-custom.gitignore

# Append to existing file using shell redirection
./gitignore.sh --print java >> existing.gitignore
```

## Supported Aliases

The script supports common aliases for languages:

- `c++`, `cpp` → C++
- `csharp`, `c#` → CSharp
- `golang` → Go
- `node`, `nodejs`, `node.js` → Node
- `objective-c`, `objc` → Objective-C
- `vb`, `visualbasic` → VisualBasic
- `ts`, `typescript` → TypeScript
- `js`, `javascript` → JavaScript (Note: JavaScript doesn't have its own template, use Node)
- `py` → Python
- `rb` → Ruby
- `yml`, `yaml` → Yaml

## Features

- **Default file writing**: Saves directly to `.gitignore` by default
- **Append mode**: Can append to existing `.gitignore` files with section headers
- **Print mode**: Option to print to stdout for piping/redirection
- **Case-insensitive**: Language names are case-insensitive
- **Multiple locations**: Searches in root, Global, and community directories
- **Color-coded output**: Status messages are color-coded
- **Error handling**: Helpful error messages when templates aren't found

## Note

The script downloads from: https://github.com/github/gitignore
