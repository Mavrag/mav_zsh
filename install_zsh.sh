#!/bin/bash

set -e

# Define colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if running as root
is_root() {
    if [ "$EUID" -eq 0 ]; then
        SUDO=''
        USER_HOME="/root"
        USER_NAME="root"
    else
        SUDO='sudo'
        USER_HOME="$HOME"
        USER_NAME="$USER"
    fi
}

# Function to check if sudo is installed
check_sudo() {
    if ! command -v sudo &> /dev/null; then
        if [ "$EUID" -ne 0 ]; then
            echo "sudo is not installed. Please install sudo or run this script as root."
            exit 1
        else
            echo -e "${GREEN}Installing sudo...${NC}"
            case "$OS" in
                ubuntu|debian|kali)
                    apt-get update -qq > /dev/null
                    apt-get install -y -qq sudo > /dev/null
                    ;;
                centos|rhel|fedora)
                    yum update -y -q > /dev/null
                    yum install -y -q sudo > /dev/null
                    ;;
                arch|manjaro)
                    pacman -Syu --noconfirm --quiet > /dev/null
                    pacman -S --noconfirm --quiet sudo > /dev/null
                    ;;
                *)
                    echo "Unsupported OS: $OS"
                    exit 1
                    ;;
            esac
        fi
    fi
}

# Function to detect OS and set package manager
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VERSION_ID=$VERSION_ID
    else
        echo "Cannot detect OS."
        exit 1
    fi

    case "$OS" in
        ubuntu|debian|kali)
            PM_UPDATE="$SUDO apt-get update -qq"
            PM_INSTALL="$SUDO apt-get install -y -qq"
            ;;
        centos|rhel|fedora)
            PM_UPDATE="$SUDO yum update -y -q"
            PM_INSTALL="$SUDO yum install -y -q"
            ;;
        arch|manjaro)
            PM_UPDATE="$SUDO pacman -Syu --noconfirm --quiet"
            PM_INSTALL="$SUDO pacman -S --noconfirm --quiet"
            ;;
        *)
            echo "Unsupported OS: $OS"
            exit 1
            ;;
    esac
}

# Function to install packages
install_packages() {
    echo -e "${GREEN}Updating package lists...${NC}"
    eval $PM_UPDATE > /dev/null
    echo -e "${GREEN}Installing required packages...${NC}"
    eval $PM_INSTALL zsh wget curl git > /dev/null
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
        echo -e "${GREEN}Installing oh-my-zsh...${NC}"
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null
    else
        echo "oh-my-zsh is already installed."
    fi
}

# Function to clone git repositories
clone_git_repo() {
    local REPO_URL=$1
    local DEST_DIR=$2
    if [ ! -d "$DEST_DIR" ]; then
        git clone -q "$REPO_URL" "$DEST_DIR" > /dev/null
    else
        echo "$DEST_DIR already exists."
    fi
}

# Function to install plugins
install_plugins() {
    echo -e "${GREEN}Installing plugins...${NC}"
    ZSH_CUSTOM="${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}"
    clone_git_repo https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    clone_git_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    clone_git_repo https://github.com/zsh-users/zsh-history-substring-search.git "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"
    clone_git_repo https://github.com/zsh-users/zsh-completions.git "${ZSH_CUSTOM}/plugins/zsh-completions"
    clone_git_repo https://github.com/lukechilds/zsh-better-npm-completion.git "${ZSH_CUSTOM}/plugins/zsh-better-npm-completion"
    clone_git_repo https://github.com/olivierverdier/zsh-git-prompt.git "${ZSH_CUSTOM}/plugins/zsh-git-prompt"
    clone_git_repo https://github.com/chrissicool/zsh-256color.git "${ZSH_CUSTOM}/plugins/zsh-256color"
    clone_git_repo https://github.com/clvv/fasd.git "${ZSH_CUSTOM}/plugins/fasd"
    clone_git_repo https://github.com/djui/alias-tips.git "${ZSH_CUSTOM}/plugins/alias-tips"
}

# Function to install fzf
install_fzf() {
    if [ ! -d "$USER_HOME/.fzf" ]; then
        echo -e "${GREEN}Installing fzf...${NC}"
        git clone --depth 1 -q https://github.com/junegunn/fzf.git "$USER_HOME/.fzf" > /dev/null
        "$USER_HOME/.fzf/install" --all --no-bash --no-fish --key-bindings --completion --update-rc > /dev/null
    else
        echo "fzf is already installed."
    fi
}

# Function to install powerlevel10k
install_powerlevel10k() {
    echo -e "${GREEN}Installing Powerlevel10k theme...${NC}"
    ZSH_CUSTOM="${ZSH_CUSTOM:-$USER_HOME/.oh-my-zsh/custom}"
    clone_git_repo https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
}

# Function to set zsh as default shell
set_default_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo -e "${GREEN}Setting zsh as the default shell...${NC}"
        $SUDO chsh -s "$(which zsh)" "$USER_NAME"
    else
        echo "zsh is already the default shell."
    fi
}

# Function to download .p10k.zsh
download_p10k_zsh() {
    echo -e "${GREEN}Downloading .p10k.zsh configuration...${NC}"
    curl -fsSL https://raw.githubusercontent.com/Mavrag/mav_zsh/main/.p10k.zsh -o "$USER_HOME/.p10k.zsh"
}

# Function to update .zshrc
update_zshrc() {
    ZSHRC="$USER_HOME/.zshrc"
    if [ -f "$ZSHRC" ]; then
        echo -e "${GREEN}Backing up existing .zshrc to .zshrc.backup...${NC}"
        cp "$ZSHRC" "$ZSHRC.backup"
    fi

    echo -e "${GREEN}Updating .zshrc configuration...${NC}"
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-better-npm-completion zsh-256color fasd alias-tips)/' "$ZSHRC"
    grep -qxF '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' "$ZSHRC" || echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> "$ZSHRC"
}

# Function to switch to zsh shell
start_zsh_shell() {
    echo -e "${GREEN}Switching to zsh shell...${NC}"
    exec zsh
}

# Main script execution
main() {
    is_root
    detect_os
    check_sudo
    install_packages
    install_oh_my_zsh
    install_plugins
    install_fzf
    install_powerlevel10k
    download_p10k_zsh
    update_zshrc
    set_default_shell
    echo -e "${GREEN}The installation was successful! Switching to zsh shell.${NC}"
    start_zsh_shell
}

main
