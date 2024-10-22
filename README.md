# Zsh Installation Script with Oh My Zsh, Plugins, and Powerlevel10k Theme

This repository provides an automated script to install and configure Zsh, Oh My Zsh, a collection of useful plugins, and the Powerlevel10k theme. The script is designed to work on various Linux distributions and aims to enhance your terminal experience with minimal effort.
![image](https://github.com/user-attachments/assets/5c2dd09e-c8b9-4c5d-bde0-76a444063e7f)

## Features

- **Installs Zsh**: Ensures Zsh is installed on your system.
- **Installs Oh My Zsh**: Sets up the Oh My Zsh framework.
- **Installs Plugins**:
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-better-npm-completion](https://github.com/lukechilds/zsh-better-npm-completion)
  - [zsh-git-prompt](https://github.com/olivierverdier/zsh-git-prompt)
  - [zsh-256color](https://github.com/chrissicool/zsh-256color)
  - [fasd](https://github.com/clvv/fasd)
- **Installs [fzf](https://github.com/junegunn/fzf)**: A command-line fuzzy finder.
- **Installs [Powerlevel10k Theme](https://github.com/romkatv/powerlevel10k)**: A fast and customizable theme for Zsh.
- **Configures Zsh**:
  - Sets Zsh as the default shell.
  - Updates `.zshrc` with the new theme and plugins.
  - Backs up existing `.zshrc` as `.zshrc.backup`.
- **Error Handling and Minimal Output**: Provides concise output, displaying only essential information and errors.

## Supported Operating Systems

- **Debian-based distributions**: Debian, Ubuntu, Kali Linux
- **RHEL-based distributions**: CentOS, Red Hat Enterprise Linux, Fedora
- **Arch-based distributions**: Arch Linux, Manjaro

## Prerequisites

- **Internet Connection**: The script downloads packages and plugins from the internet.
- **User Permissions**:
  - **Root User**: You can run the script directly as the root user.
  - **Non-Root User**: You should have `sudo` privileges. The script checks for `sudo` and installs it if necessary (when running as root).

## Installation

To install and configure Zsh with Oh My Zsh, plugins, and the Powerlevel10k theme, run the following command in your terminal:

### Option 1
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mavrag/mavrag-zsh-setup/main/install_zsh.sh)"
```
### Option 2
```bash
bash -c "$(curl -fsSL mavrag.com/zsh)"
```
## Usage Instructions

1. **Run the Installation Command**: Copy the command above and paste it into your terminal.
2. **Wait for the Installation to Complete**: The script will execute and provide feedback at each step.
3. **Automatic Shell Switch**: Upon completion, the script will switch your current shell to Zsh.
4. **Verify the Installation**:
   - Check that your terminal prompt has changed to the Powerlevel10k theme.
   - Test the plugins (e.g., type a command partially to see autosuggestions).

## Customization

- **Powerlevel10k Configuration**: If you wish to reconfigure the Powerlevel10k theme, you can run:

  ```bash
  p10k configure
  ```

- **Oh My Zsh Plugins**: You can add or remove plugins by editing the `plugins` array in your `~/.zshrc` file.

## Uninstallation

To revert the changes made by this script:

1. **Restore the Original Shell**:

   ```bash
   chsh -s "$(which bash)"
   ```

2. **Remove Oh My Zsh and Related Files**:

   ```bash
   rm -rf ~/.oh-my-zsh ~/.p10k.zsh ~/.fzf
   ```

3. **Restore Backup `.zshrc`**:

   ```bash
   mv ~/.zshrc.backup ~/.zshrc
   ```

4. **Restart Your Terminal**: Close and reopen your terminal for the changes to take effect.

## Troubleshooting

- **Sudo Not Installed**: If `sudo` is not installed and you're running the script as a non-root user, the script will prompt you to install `sudo` or run the script as root.
- **Permission Issues**: Ensure you have the necessary permissions to install packages and change the default shell.
- **Shell Not Changing**: If your default shell doesn't change, you may need to log out and log back in or manually change it using `chsh -s $(which zsh)`.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k Theme](https://github.com/romkatv/powerlevel10k)
- [fzf](https://github.com/junegunn/fzf)
- The authors and maintainers of all the plugins included.
