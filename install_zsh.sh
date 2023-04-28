#!/bin/bash
# Download .p10k.zsh
wget https://raw.githubusercontent.com/Mavrag/mav_zsh/main/.p10k.zsh -o ~/.p10k.zsh
# Check if OS is Ubuntu
if [[ $(lsb_release -is) == "Ubuntu" || $(lsb_release -is) == "Kali" ]]; then
    # Install zsh
    sudo apt-get update
    sudo apt-get install -y zsh

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
	git clone https://github.com/wting/autojump.git ~/.oh-my-zsh/custom/plugins/autojump
	git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Install powerlevel10k
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

    # Set zsh as default shell
    chsh -s /bin/zsh

    # Set powerlevel10k theme
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

    # Add plugins to .zshrc
	sed -i 's/^plugins=.*/plugins=(git fzf zsh-navigation-tools zsh-interactive-cd alias-tips zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-navigation-tools zsh-better-npm-completion zsh-256color fasd autojump alias-tips command-not-found extract docker)/' ~/.zshrc

# Check if OS is CentOS
elif [[ $(rpm -q centos-release | cut -d- -f3) == "7" ]]; then
    # Install zsh
    sudo yum install -y zsh

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
	git clone https://github.com/wting/autojump.git ~/.oh-my-zsh/custom/plugins/autojump
	git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Install powerlevel10k
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

    # Set zsh as default shell
    chsh -s /bin/zsh

    # Set powerlevel10k theme
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

    # Add plugins to .zshrc
	sed -i 's/^plugins=.*/plugins=(git fzf zsh-navigation-tools zsh-interactive-cd alias-tips zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-navigation-tools zsh-better-npm-completion zsh-256color fasd autojump alias-tips command-not-found extract docker)/' ~/.zshrc

# Check if OS is Arch Linux
elif [[ $(lsb_release -is) == "Arch" ]]; then
    # Install zsh
    sudo pacman -S --noconfirm zsh

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
	git clone https://github.com/wting/autojump.git ~/.oh-my-zsh/custom/plugins/autojump
	git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

	# Install fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

	# Install powerlevel10k
	git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

	# Set zsh as default shell
	chsh -s /bin/zsh

	# Set powerlevel10k theme
	sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

	# Add plugins to .zshrc
	sed -i 's/^plugins=.*/plugins=(git fzf zsh-navigation-tools zsh-interactive-cd alias-tips zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-navigation-tools zsh-better-npm-completion zsh-256color fasd autojump alias-tips command-not-found extract docker)/' ~/.zshrc
else
echo "Unsupported OS"
fi
