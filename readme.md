# Installation

## Mac

### Install *brew*
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install
```

### Install everything else

```bash
# checking for missing dependencies
brew bundle check -v
# installing and updating missing dependencies
brew bundle install
# update bundle
brew bundle dump --force
```

## Arch, btw

### Install *1password*

```bash
curl https://raw.githubusercontent.com/Cethrivias/dotfiles/HEAD/scripts/install-1password.sh | bash
```

### Install other dependencies

```bash
curl https://raw.githubusercontent.com/Cethrivias/dotfiles/HEAD/scripts/initial-setup.sh | bash
```

# Linking dotfiles

```bash
stow -t $HOME ghostty
stow -t $HOME yazi
stow -t $HOME mc
stow -t $HOME nvim
stow -t $HOME tmux
stow -t $HOME zsh
stow -t $HOME aerospace
stow -t $HOME MangoHud
```

# Other setup

SSH keys setup is described well in this
[GitHub page](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

# Special characters

- [Nerd Fond](https://www.nerdfonts.com/cheat-sheet)
- [Unicode](https://symbl.cc/en/search)
