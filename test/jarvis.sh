#!/bin/bash

          # Global Variables:


    # --- GitHub Configuration ---

# GitHub email:
GITHUB_EMAIL="juancrfig@gmail.com"

# Github username:
GITHUB_USERNAME="juancrfig"

# Repository's SSH link:
GITHUB_REPO="git@github.com:juancrfig/notes.git"


  # --- System Customization ---
  # --- Terminal Customization ---

# Terminal's background color in RGB or hex(#) format:
BACKGROUND_COLOR="#000000"

# Terminal's transparency level (0-100):
BACKGROUND_TRANSPARENCY_PERCENT=38

# Font Style and Size:
FONT="Liberation Mono 12"

# Terminal's Font Color  in RGB or hex format(#):
FOREGROUND_COLOR="rgb(255,255,255)"

add_auto_descargas() {
  local bashrc="$HOME/.bashrc"
  local marker="# Auto-change to ~/Descargas start"
  local end_marker="# Auto-change to ~/Descargas end"

  # Check if the marker already exists in .bashrc to prevent duplicate entries.
  if grep -q "$marker" "$bashrc"; then
    echo "Auto-descargas snippet is already present in $bashrc"
    return 0
  fi

  # Append the snippet to .bashrc.
  cat << 'EOF' >> "$bashrc"
# Auto-change to ~/Descargas start
auto_descargas() {
  if [ -d "$HOME/Descargas" ]; then
    cd "$HOME/Descargas"
  else
    echo "Directory $HOME/Descargas does not exist."
  fi
}
auto_descargas
# Auto-change to ~/Descargas end
EOF

  echo "Auto-descargas snippet added to $bashrc"
}

setup_vim_alias() {
    local BASHRC="$HOME/.bashrc"
    local ZSHRC="$HOME/.zshrc"
    local FUNCTION_DEF='vim() { command nvim "$@"; }'

    # Add the function to .bashrc if not already present
    if ! grep -q 'vim() {' "$BASHRC"; then
        echo "$FUNCTION_DEF" >> "$BASHRC"
        echo "Added function to $BASHRC"
    fi

    # Add the function to .zshrc if Zsh is used
    if [ -f "$ZSHRC" ] && ! grep -q 'vim() {' "$ZSHRC"; then
        echo "$FUNCTION_DEF" >> "$ZSHRC"
        echo "Added function to $ZSHRC"
    fi

    # Apply changes immediately
    if [ -n "$ZSH_VERSION" ]; then
        source "$ZSHRC"
    else
        source "$BASHRC"
    fi

    echo "Setup complete. Type 'vim' to run 'nvim'."
}



# Function to prompt the user for missing variables
check_variables() {
    if [ -z "$GITHUB_EMAIL" ]; then
        read -p "There's no defined email. Please enter one: " GITHUB_EMAIL
	# Update the script file to include the new value
	sed -i.bak -E "s/^(GITHUB_EMAIL=).*/\1\"$GITHUB_EMAIL\"/" "$0"
    fi

    if [ -z "$GITHUB_USERNAME" ]; then
        read -p "There's no defined username. Please enter one: " GITHUB_USERNAME
        # Update the script file to include the new value
        sed -i.bak -E "s/^(GITHUB_USERNAME=).*/\1\"$GITHUB_USERNAME\"/" "$0"
    fi

    if [ -z "$GITHUB_REPO" ]; then
        read -p "There's no defined default Github repository. Please enter one: " GITHUB_REPO
        # Update the script file to include the new value
        sed -i.bak -E "s|^(GITHUB_REPO=).*|\1\"$GITHUB_REPO\"|" "$0"
    fi

    if [ -z "$IMAGE_URL" ]; then
        read -p "There's no defined image URL. Please enter one: " IMAGE_URL
        # Update the script file to include the new value
        sed -i.bak -E "s|^(IMAGE_URL=).*|\1\"$IMAGE_URL\"|" "$0"
    fi

}

# Function to install Java 21 without sudo
install_java() {
  # Check if the Java version is provided as an argument
  if [ -z "$1" ]; then
    echo "Installing Java 21..."
    JAVA_VERSION="21"
    JAVA_URL="https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz"
  else
    JAVA_VERSION=$1
    JAVA_URL="https://download.oracle.com/java/$JAVA_VERSION/latest/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"
  fi
  
  INSTALL_DIR="$HOME/java"
  
  # Create the installation directory if it doesn't exist
  mkdir -p "$INSTALL_DIR"
  
  # Download the Java tar.gz file
  echo "Downloading Java $JAVA_VERSION..."
  wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "$JAVA_URL" -O "$INSTALL_DIR/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"
  
  # Extract the downloaded tar.gz file
  echo "Extracting Java $JAVA_VERSION..."
  tar -xf "$INSTALL_DIR/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" -C "$INSTALL_DIR"
  
  # Find the actual JDK directory name after extraction
  JDK_DIR=$(find "$INSTALL_DIR" -maxdepth 1 -type d -name "jdk-*" | head -n 1)
  
  # If JDK directory not found, try another pattern
  if [ -z "$JDK_DIR" ]; then
    JDK_DIR=$(find "$INSTALL_DIR" -maxdepth 1 -type d -name "jdk*" | head -n 1)
  fi
  
  # Check if we found the JDK directory
  if [ -z "$JDK_DIR" ]; then
    echo "Error: Could not find the JDK directory after extraction."
    return 1
  fi
  
  # Remove the tar.gz file after extraction
  rm "$INSTALL_DIR/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"
  
  # Update .bashrc or .zshrc to set JAVA_HOME and update PATH
  echo "Setting up environment variables..."
  if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
  elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
  else
    echo "No suitable shell configuration file found."
    return 1
  fi
  # Remove previous JAVA_HOME and PATH entries if they exist
sed -i '/export JAVA_HOME=.*java.*\/jdk.*/d' "$SHELL_CONFIG"
sed -i '/export PATH=.*JAVA_HOME\/bin.*/d' "$SHELL_CONFIG"

# Add JAVA_HOME and append it to PATH, ensuring essential system directories are included
echo "export JAVA_HOME=$JDK_DIR" >> "$SHELL_CONFIG"
echo 'export PATH=$JAVA_HOME/bin:/usr/bin:/bin:$PATH' >> "$SHELL_CONFIG"
  
  echo "Java $JAVA_VERSION installed successfully!"
  echo "Please run 'source $SHELL_CONFIG' or start a new terminal to apply changes."
  echo "Then verify the installation with 'java -version'"
}

install_neovim() {
    # Check if neovim is already installed
    if command -v nvim >/dev/null 2>&1; then
        echo "Neovim is already installed."
        return 0
    fi

    # Create a Descargas directory if it doesn't exist
    mkdir -p ~/Descargas

    # Download Neovim
    echo "Downloading Neovim..."
    wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz -O ~/Descargas/nvim-linux-x86_64.tar.gz > /dev/null 2>&1

    # Extract Neovim to user's home directory
    echo "Extracting Neovim..."
    tar -xzvf ~/Descargas/nvim-linux-x86_64.tar.gz -C ~/ > /dev/null 2>&1
    
    echo 'export PATH="$HOME/nvim-linux-x86_64/bin:/usr/bin:/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    
    # Clean up downloaded archive
    rm ~/Descargas/nvim-linux-x86_64.tar.gz
}

clone_nvim_config() {
    # Ensure .config directory exists
    mkdir -p ~/.config/nvim

    # Clone the repository
    git clone git@github.com:juancrfig/nvim.git ~/Descargas/nvim_temp

    # Remove .git folder and copy contents to config
    rm -rf ~/Descargas/nvim_temp/.git
    cp -r ~/Descargas/nvim_temp/* ~/.config/nvim/

    # Clean up temporary download
    rm -rf ~/Descargas/nvim_temp
}

# Main function to run both installation steps
setup_neovim() {
    install_neovim
    clone_nvim_config
    echo "Neovim installation and configuration complete!"
}

sql() {
    mysql -u campus2023 -pcampus2023
}

# Spinner function that tracks a specific process
show_spinner() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spin='|/-\'
    
    while ps -p $pid >/dev/null 2>&1; do
        for i in $(seq 0 3); do
            printf "\r[%c] %s" "${spin:$i:1}" "$message"
            sleep $delay
        done
    done
    printf "\r[✔] %s\n" "$message"
}

# Function to personalize the terminal
customize_terminal() {
    PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    PROFILE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

    # Background color
    gsettings set $PROFILE_PATH background-color "$BACKGROUND_COLOR"

    # Transparency
    gsettings set $PROFILE_PATH use-transparent-background true
    gsettings set $PROFILE_PATH background-transparency-percent $BACKGROUND_TRANSPARENCY_PERCENT

    # Cursor properties
    gsettings set $PROFILE_PATH cursor-shape 'block'
    gsettings set $PROFILE_PATH cursor-blink-mode 'on'

    # Theme and colors
    gsettings set $PROFILE_PATH use-theme-colors false

    # Font settings
    gsettings set $PROFILE_PATH use-system-font false
    gsettings set $PROFILE_PATH font "$FONT"
    gsettings set $PROFILE_PATH foreground-color "$FOREGROUND_COLOR"
    
    # File and directory colors
    if ! grep -q 'Custom colors for files and directories' ~/.bashrc; then
        cat >> ~/.bashrc << 'EOF'
# Custom colors for files and directories
LS_COLORS="di=1;34:ln=1;36:ex=1;32:*.jpg=1;35:*.png=1;35:*.txt=0;37"
export LS_COLORS

# Enable color support
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias grep="grep --color=auto"
EOF
    fi

    # Add custom prompt colors
    if ! grep -q 'Custom colored prompt' ~/.bashrc; then
        cat >> ~/.bashrc << 'EOF'
# Custom colored prompt
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
RESET='\[\033[0m\]'
PS1="${GREEN}\u${RESET}@${BLUE}\h${RESET}:${PURPLE}\w${RESET}\$ "
EOF
    fi

    echo "set tabsize 4" >> ~/.nanorc
    echo "set tabstospaces" >> ~/.nanorc

    # Apply changes
    source ~/.bashrc
    reset
}

# Funcion para configurar Git
configure_git() {
    git config --global user.name "$GITHUB_USERNAME"
    git config --global user.email "$GITHUB_EMAIL"
    git config --global core.editor "code --wait"
    git config --global init.defaultBranch main
    git config --global color.ui auto
    git config --global pull.rebase false
    git config --global core.autocrlf input
    git config --global core.abbrev 10
}

# Funcion para limpiar VS Code
cleanup_vscode() {

        # Kill VS Code processes
        pkill -f "code" 2>/dev/null

        # Force kill if still running
        if pgrep -f "code" > /dev/null; then
                pkill -9 -f "code"
        fi

    local vscode_paths=(
        "$HOME/.config/Code"
        "$HOME/.vscode"
        "$HOME/.config/Code - OSS"
        "$HOME/.local/share/code"
        "$HOME/.local/share/code-oss"
        "$HOME/.cache/code"
        "$HOME/.cache/code-oss"
        "$HOME/.vscode/extensions"
    )
    
    for path in "${vscode_paths[@]}"; do
        rm -rf "$path" 2>/dev/null
    done
}

cleanup_browsers() {

    # Ensure both browsers are completely closed
    pkill -f firefox
    pkill -f chrome
    pkill -f chromium
    sleep 2

    # Paths for Firefox cleanup
    firefox_paths=(
        "$HOME/.mozilla/firefox"
        "$HOME/.cache/mozilla/firefox"
        "$HOME/.config/firefox"
        "$HOME/.local/share/firefox"
        "$HOME/.local/share/mozilla"
        "$HOME/.local/state/mozilla"
        "$HOME/.mozilla/firefox/*.default*"
        "$HOME/.mozilla/firefox/*.default-release*"
        "$HOME/.mozilla/firefox/profiles.ini"
        "$HOME/snap/firefox"
        "$HOME/snap/firefox/common/.mozilla"
        "$HOME/snap/firefox/common/.cache/mozilla"
        "$HOME/.var/app/org.mozilla.firefox"
        "$HOME/.var/app/org.mozilla.firefox/.mozilla"
        "$HOME/.var/app/org.mozilla.firefox/.cache"
        "$HOME/.mozilla/firefox/*default*/logins.json"
        "$HOME/.mozilla/firefox/*default*/key*.db"
        "$HOME/.mozilla/firefox/*default*/cookies.sqlite"
    )

    # Paths for Google Chrome cleanup
    chrome_paths=(
        "$HOME/.config/google-chrome"
        "$HOME/.cache/google-chrome"
        "$HOME/.local/share/google-chrome"
        "$HOME/.local/state/google-chrome"
        "$HOME/snap/chromium"
        "$HOME/snap/chromium/common/.cache"
        "$HOME/snap/chromium/common/.config"
        "$HOME/.var/app/com.google.Chrome"
        "$HOME/.var/app/com.google.Chrome/.cache"
        "$HOME/.var/app/com.google.Chrome/.config"
        "$HOME/.config/chromium"
        "$HOME/.cache/chromium"
        "$HOME/.local/share/chromium"
        "$HOME/.local/state/chromium"
    )

    # Combine paths for cleanup
    all_paths=("${firefox_paths[@]}" "${chrome_paths[@]}")

    # Remove all browser-related files
    for path in "${all_paths[@]}"; do
        # Use find to handle wildcards and remove files/directories
        find "${path%/*}" -path "$path" -prune -exec rm -rf {} + 2>/dev/null
    done
}

# Function to handle SSH setup
setup_ssh() {
    
    local SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
    
    # Generate SSH key
    ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$SSH_KEY_PATH" -N "" || log_error "Failed to generate SSH key"
    
    # Start SSH agent and add key
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_PATH" || log_error "Failed to add SSH key to agent"
    
    # Display public key
    echo -e "\nAdd this public key to GitHub (https://github.com/settings/keys):"
    cat "${SSH_KEY_PATH}.pub"
    
    # Wait for user confirmation
    read -p "Press [Enter] after adding the key to GitHub..."
    
    # Clone repository
    GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone "$GITHUB_REPO" || log_error "Failed to clone repository"
}

# Function to clean SSH
cleanup_ssh() {
    ssh-add -d "$HOME/.ssh/id_ed25519" 2>/dev/null
    rm -f "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_ed25519.pub" 2>/dev/null
}

IMAGE_URL="https://images3.alphacoders.com/112/1120397.png"

set_wallpaper() {

        # Configuration
        DEST_FOLDER="$HOME/Pictures"
        FILENAME="wallpaper.jpg"
        WALLPAPER_PATH="$DEST_FOLDER/$FILENAME"

        # Create wallpapers directory if it doesn't exist
        mkdir -p "$DEST_FOLDER"

        # Download the image with optimized curl command
        if curl -L \
            -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
            -H "Accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8" \
            -H "Referer: https://uhdpaper.com/" \
            --compressed \
            -o "$WALLPAPER_PATH" \
            "$IMAGE_URL"; then

            # Verify the download was successful
            if [ -f "$WALLPAPER_PATH" ] && [ -s "$WALLPAPER_PATH" ]; then
                # Set the wallpaper for both light and dark themes
                gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
                gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"
                gsettings set org.gnome.desktop.background picture-options 'scaled'
            else
                echo "❌ Error: Download failed or file is empty"
            fi
        else
            echo "❌ Error: Failed to download the image"
        fi
}


clean_desktop() {
    # Dynamically set the desktop directory using xdg-user-dir for locale awareness
    DESKTOP_DIR=$(xdg-user-dir DESKTOP)

    # Safety check: Ensure DESKTOP_DIR is not the home directory
    if [ "$DESKTOP_DIR" = "$HOME" ]; then
        echo "Error: Desktop directory is set to home directory. Aborting."
        return 1
    fi

    # Check if the desktop directory exists
    if [ ! -d "$DESKTOP_DIR" ]; then
        echo "Desktop directory not found."
        return 1
    fi

    # Safely remove all contents of the desktop directory
    find "$DESKTOP_DIR" -mindepth 1 -delete

    # Disable showing personal folder
    gsettings set org.gnome.shell.extensions.ding show-home false

    # Enable auto-hiding of the dock
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.shell.extensions.dash-to-dock autohide true


    echo "Desktop cleaned successfully."
}

# Function to delete the script itself
self_delete() {
    # Save the path to the script
    local script_path="$0"
    
    # Path to the folder to delete
    local folder_path="/home/camper/Descargas/jarvis"
    
    # Delete the folder and its contents
    if rm -rf "$folder_path"; then
        echo "Folder deleted successfully"
    else
        echo "Failed to delete folder"
    fi
    
    # Delete the script
    if rm -f "$script_path"; then
        echo "Script deleted successfully"
    else
        echo "Failed to delete script"
    fi
}

# Obsidian installation and launch function
obsidian() {
    local URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/Obsidian-1.7.7.AppImage"
    local DESTINATION="$HOME/Descargas"
    local FILENAME="Obsidian.AppImage"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$DESTINATION"
    cd "$DESTINATION" || exit 1
    
    # Download and setup in a subshell with process tracking
    (
        # Download the file
        if ! curl -L "$URL" -o "$FILENAME" > /dev/null 2>&1 ; then
            echo "Download failed!"
            exit 1
        fi
        
        chmod +x "$FILENAME"
        
        # Extract AppImage
        if ! ./"$FILENAME" --appimage-extract >/dev/null 2>&1; then
            echo "Extraction failed!"
            exit 1
        fi
        
        rm "$FILENAME"
        [[ -d obsidian-folder ]] && rm -rf obsidian-folder
        mv squashfs-root obsidian-folder
    ) &
    
    # Store background process PID
    local setup_pid=$!
    
    # Show spinner while waiting for the setup
    show_spinner $setup_pid "Downloading and setting up Obsidian..."
    
    # Wait for setup to complete
    wait $setup_pid
    
    if [ $? -eq 0 ]; then
        # Launch Obsidian with complete detachment
        nohup "$DESTINATION/obsidian-folder/obsidian" >/dev/null 2>&1 & disown
    else
        echo "An error occurred during installation."
        exit 1
    fi
}

cursor() {
    local URL="https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-0.46.11-ae378be9dc2f5f1a6a1a220c6e25f9f03c8d4e19.deb.glibc2.25-x86_64.AppImage"
    local DESTINATION="$HOME/Descargas"
    local FILENAME="Cursor.AppImage"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$DESTINATION"
    cd "$DESTINATION" || exit 1
    
    # Download and setup in a subshell with process tracking
    (
        # Download the file
        if ! curl -L "$URL" -o "$FILENAME" > /dev/null 2>&1 ; then
            exit 1
        fi

        chmod +x "$FILENAME"

        # Extract AppImage
        if ! ./"$FILENAME" --appimage-extract >/dev/null 2>&1; then
            exit 1
        fi

        rm "$FILENAME"
        [[ -d cursor-folder ]] && rm -rf cursor-folder
        mv squashfs-root cursor-folder
    ) &
    
    # Store background process PID
    local setup_pid=$!
    
    # Show spinner while waiting for the setup
    show_spinner $setup_pid "Downloading and setting up Cursor..."
    
    # Wait for setup to complete
    wait $setup_pid
    
    if [ $? -eq 0 ]; then
        # Launch Cursor with complete detachment
        nohup "$DESTINATION/cursor-folder/AppRun" >/dev/null 2>&1 & disown
    else
        echo "An error occurred during installation."
        exit 1
    fi
}

setup_nvm() {
    # Install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # Set up NVM_DIR environment variable
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

    # Load nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    # Check nvm version
    nvm --version
    nvm -v

    # Install the latest version of Node.js
    nvm install node
}

libraries() {
    pip install kivy
    pip install selenium &> /dev/null
    pip install undetected-chromedriver &> /dev/null
}

set_dark_theme() {
    # Set the dark them for the system
    gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
}

cleanup_folder() {
    
    script_path="/home/camper/Descargas/jarvis.sh"
    script_dir=$(dirname "$script_path")
    script_name=$(basename "$script_path")

    # Delete everything except the script itself
    find /home/camper/Descargas -mindepth 1 ! -name "$script_name" ! -name "jarvis-master" ! -name "jarvis" ! -name "menu.py" ! -name "img" ! -name "jarvis-menu.png" ! -name "happy_jarvis.py"  -delete
}

# Defining stuff for installing Ollama

red="$( (/usr/bin/tput bold || :; /usr/bin/tput setaf 1 || :) 2>&-)"
plain="$( (/usr/bin/tput sgr0 || :) 2>&-)"

status() { echo ">>> $*" >&2; }
error() { echo "${red}ERROR:${plain} $*"; exit 1; }
warning() { echo "${red}WARNING:${plain} $*"; }

available() { command -v $1 >/dev/null; }
require() {
    local MISSING=''
    for TOOL in $*; do
        if ! available $TOOL; then
            MISSING="$MISSING $TOOL"
        fi
    done
    echo $MISSING
}

[ "$(uname -s)" = "Linux" ] || error 'This script is intended to run on Linux only.'

ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) error "Unsupported architecture: $ARCH" ;;
esac

VER_PARAM="${OLLAMA_VERSION:+?version=$OLLAMA_VERSION}"

NEEDS=$(require curl awk grep sed tee xargs)
if [ -n "$NEEDS" ]; then
    status "ERROR: The following tools are required but missing:"
    for NEED in $NEEDS; do
        echo "  - $NEED"
    done
    exit 1
fi



# Main script execution
case "$1" in
    "hello")
    install_neovim >/dev/null 2>&1
    setup_vim_alias >/dev/null 2>&1
    clean_desktop >/dev/null 2>&1
    set_wallpaper >/dev/null 2>&1
	check_variables >/dev/null 2>&1
        # Start tasks that don't depend on GitHub credentials in the background
        (set_dark_theme > /dev/null 2>&1 || true; echo "") &
        (cleanup_folder > /dev/null 2>&1 || true; echo "") &
        (set_wallpaper > /dev/null 2>&1 || true; echo "") &
        (customize_terminal > /dev/null 2>&1 || true; echo "") &
        (cleanup_vscode > /dev/null 2>&1 || true; echo "") &
        (xdg-settings set default-web-browser google-chrome.desktop || log_error "Failed to set the default browser" || true) &
        (setup_nvm > /dev/null 2>&1 || true; echo "" ) &
        (libraries > /dev/null 2>&1 || true; echo "") &
        
        # Handle Git and SSH setup separately
        if [ -n "$GITHUB_USERNAME" ] && [ -n "$GITHUB_EMAIL" ]; then
            # Configure Git
            configure_git
            
            # Handle SSH setup
            SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
            
            # Generate SSH key
            ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$SSH_KEY_PATH" -N "" || { echo "Failed to generate SSH key"; }
            
            if [ $? -eq 0 ]; then
                # Start SSH agent and add key
                eval "$(ssh-agent -s)"
                ssh-add "$SSH_KEY_PATH" || { echo "Failed to add SSH key to agent"; }
                
                # Display public key
                echo -e "\nAdd this public key to GitHub (https://github.com/settings/keys):"
                cat "${SSH_KEY_PATH}.pub"
                
                # Wait for user confirmation
                read -p "Press [Enter] after adding the key to GitHub..."
                
                # Clone repository only if GITHUB_REPO is defined
                if [ -n "$GITHUB_REPO" ]; then
                    GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone "$GITHUB_REPO" || echo "Failed to clone repository"
                    echo "Repository cloned successfully"
                fi
                
            fi
        fi

        clone_nvim_config > /dev/null 2>&1

        export PATH="/usr/bin:/bin:/usr/local/bin:$PATH"
        
        # Wait for background processes to complete
        wait
        
        echo "Protocolo de bienvenida completado exitosamente"
        ;;
    "obsidian")
	obsidian
	;;
    "cursor")
        cursor
	;;
    "sql")
    	sql
	;;
    "desk")
    clean_desktop
    ;;
"resolutio")
    OLLAMA_INSTALL_DIR="$HOME/Descargas/ollama"
    BINDIR="$OLLAMA_INSTALL_DIR/bin"
    
    # Create installation directories
    mkdir -p "$OLLAMA_INSTALL_DIR/lib/ollama"
    mkdir -p "$BINDIR"

    if [ -d "$OLLAMA_INSTALL_DIR/lib/ollama" ] ; then
        status "Cleaning up old version at $OLLAMA_INSTALL_DIR/lib/ollama"
        rm -rf "$OLLAMA_INSTALL_DIR/lib/ollama"
    fi

    status "Installing ollama to $OLLAMA_INSTALL_DIR"
    status "Downloading Linux ${ARCH} bundle"
    curl --fail --show-error --location --progress-bar \
    "https://ollama.com/download/ollama-linux-${ARCH}.tgz${VER_PARAM}" | \
    tar -xzf - -C "$OLLAMA_INSTALL_DIR"

    if [ "$OLLAMA_INSTALL_DIR/bin/ollama" != "$BINDIR/ollama" ] ; then
        status "Making ollama accessible in $BINDIR"
        ln -sf "$OLLAMA_INSTALL_DIR/ollama" "$BINDIR/ollama"
    fi
    
    # Add to PATH and update current session
    echo 'export PATH="$PATH:$HOME/Descargas/ollama/bin"' >> ~/.bashrc
    export PATH="$PATH:$HOME/Descargas/ollama/bin"

    status "Starting ollama server in background..."
    nohup ollama serve > /dev/null 2>&1 &
    OLLAMA_PID=$!
    disown $OLLAMA_PID
    
    # Store PID for later use
    echo $OLLAMA_PID > "$OLLAMA_INSTALL_DIR/ollama.pid"
    
    # Additional small wait to ensure server is up
    status "Waiting for server to start..."
    sleep 5
    
    # Run llama2 model
    status "Running llama2 model..."
    ollama run llama2
    ;;

    "bye")
        
        # Path to the PID file
        OLLAMA_PID_FILE="$HOME/Descargas/ollama/ollama.pid"

        # Check if PID file exists
        if [ -f "$OLLAMA_PID_FILE" ]; then
            OLLAMA_PID=$(cat "$OLLAMA_PID_FILE")

            # Check if the process is still running
            if ps -p $OLLAMA_PID > /dev/null; then
                status "Stopping ollama server..."
                kill $OLLAMA_PID
                rm "$OLLAMA_PID_FILE"
                status "Ollama server stopped successfully"
            else
                status "Ollama server is not running"
                rm "$OLLAMA_PID_FILE"
            fi
        else
            status "No ollama server PID file found"
        fi
        
        cleanup_ssh 
        cleanup_discord
        cleanup_vscode
        cleanup_browsers
        cleanup_folder

        rm ~/.gitconfig
        touch ~/.gitconfig

        # Clear terminal history
        history -c && history -w

        sleep 10 && shutdown now
        self_delete
        ;;

    "happy")
	chmod +x happy_jarvis.py
	echo "Happy mode activated"
	./python_scripts/happy_jarvis.py
	;;
    "test")
    	add_auto_descargas
	;;	

    *)
        echo "Usage: $0 {hello|obsidian|bye|review|happy}"
        echo "  hello         - Initial setup (VS Code cleanup, Git config, Firefox default)"
        echo "  obsidian      - Download Obsidian app, then open it"
        echo "  bye           - Cleanup all data and configurations"
        echo "  happy         - Run the Python script (review.py)"
	echo "  cursor        - Download Cursor app, then open it"
        exit 1        
	;;
esac
