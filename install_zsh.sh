#!/bin/bash

# Check if OS is Ubuntu or Kali
if [[ $(lsb_release -is) == "Ubuntu" || $(lsb_release -is) == "Kali" || $(lsb_release -is) == "Debian" ]]; then
    # Install zsh
    sudo apt-get update
    sudo apt-get install -y zsh wget curl git
elif [[ $(rpm -q centos-release | cut -d- -f3) == "7" ]]; then
    # Install zsh
    sudo yum install -y zsh wget curl git
elif [[ $(lsb_release -is) == "Arch" ]]; then
    # Install zsh
    sudo pacman -S --noconfirm zsh wget curl git
else
    echo "Unsupported OS"
    exit 1
fi
# Download .p10k.zsh
curl -f https://raw.githubusercontent.com/Mavrag/mav_zsh/main/.p10k.zsh -o ~/.p10k.zsh
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/lukechilds/zsh-better-npm-completion.git ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.oh-my-zsh/custom/plugins/zsh-git-prompt
git clone https://github.com/chrissicool/zsh-256color.git ~/.oh-my-zsh/custom/plugins/zsh-256color
git clone https://github.com/clvv/fasd.git ~/.oh-my-zsh/custom/plugins/fasd
git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Set zsh as default shell
sudo chsh -s $(which zsh) $USER

# Set powerlevel10k theme
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Add plugins to .zshrc
sed -i 's/^plugins=.*/plugins=( git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-better-npm-completion zsh-256color fasd alias-tips )/' ~/.zshrc
sed -i '$ a\[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' ~/.zshrc
echo "The installation was successful!"
exit 0
