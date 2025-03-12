#!/bin/bash

# Update package list
sudo dnf update -y

# Install Homebrew (Linuxbrew)
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install zsh
if ! command -v zsh &> /dev/null
then
    echo "Installing zsh..."
    sudo dnf install -y zsh
fi

# Change default shell to zsh
chsh -s $(which zsh)

# Install oh-my-posh
if ! command -v oh-my-posh &> /dev/null
then
    echo "Installing oh-my-posh..."
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

# Install oh-my-posh theme
echo "Setting up oh-my-posh theme..."
mkdir -p ~/.config/oh-my-posh
curl -o ~/.config/oh-my-posh/mytheme.omp.json https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/robbyrussell.omp.json

# Add oh-my-posh theme to zsh config
echo 'eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/mytheme.omp.json)"' >> ~/.zshrc

# Install zoxide
if ! command -v zoxide &> /dev/null
then
    echo "Installing zoxide..."
    brew install zoxide
fi

# Install bat
if ! command -v bat &> /dev/null
then
    echo "Installing bat..."
    brew install bat
fi

# Add zoxide and bat integration to zsh config
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
echo 'function cd { zoxide cd "$@" && ls | bat --paging=always --style=plain --color=always; }' >> ~/.zshrc

# Source zsh config
source ~/.zshrc

echo "Installation and configuration complete. Please restart your terminal."
