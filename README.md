# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a **stow package** that mirrors the target layout relative to `$HOME`:

```
<package>/
├── .config/<app>/...      → ~/.config/<app>/...
├── .local/bin/...          → ~/.local/bin/...
├── .local/share/...        → ~/.local/share/...
└── .ssh/...                → ~/.ssh/...
```

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/) (2.3+)
- Git

### Install Stow

```bash
# Arch Linux
sudo pacman -S stow

# Debian/Ubuntu
sudo apt install stow

# macOS
brew install stow
```

## Installation

```bash
git clone git@github.com:cccheng/dotfiles.git ~/.confi9
cd ~/.confi9
```

### Stow individual packages

```bash
# Symlink a single package
stow bash

# Symlink multiple packages
stow git neovim tmux
```

### Stow all packages

```bash
stow */
```

### Preview changes (dry run)

```bash
stow -n -v bash
```

## Uninstalling

```bash
# Remove symlinks for a package
stow -D bash

# Remove all
stow -D */
```

