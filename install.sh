#!/bin/bash

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install all software from Brewfile
brew bundle install

# Remove default macOS apps from Dock
dockutil --remove 'Launchpad' --allhomes
dockutil --remove 'Siri' --allhomes
dockutil --remove 'Safari' --allhomes
dockutil --remove 'Mail' --allhomes
dockutil --remove 'Contacts' --allhomes
dockutil --remove 'Reminders' --allhomes
dockutil --remove 'Maps' --allhomes
dockutil --remove 'Photos' --allhomes
dockutil --remove 'Messages' --allhomes
dockutil --remove 'FaceTime' --allhomes
dockutil --remove 'App Store' --allhomes
dockutil --remove 'System Preferences' --allhomes
dockutil --remove 'Podcasts' --allhomes
dockutil --remove 'TV' --allhomes
dockutil --remove 'Keynote' --allhomes
dockutil --remove 'Music' --allhomes
dockutil --remove 'Freeform' --allhomes
dockutil --remove 'Numbers' --allhomes
dockutil --remove 'Pages' --allhomes

# Add preferred apps to Dock
dockutil --add '/Applications/Mattermost.app' --position 1 --allhomes
dockutil --add '/Applications/Google Chrome.app' --position 2 --allhomes
dockutil --add '/Applications/Sublime Text.app' --position 3 --allhomes
dockutil --add '/Applications/iTerm.app' --position 4 --allhomes

# Install Grunt and Sass
npm install --global grunt-cli
gem install sass --user-install

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi

# Set ZSH theme to agnoster
sed -i '' -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Fix insecure zsh directories
compaudit | xargs chmod g-w,o-w

# Install Powerline if not installed
if [ ! -d "$HOME/powerline" ]; then
  git clone git@github.com:carlcarl/powerline-zsh ~/powerline
  ln -s ~/powerline/powerline-zsh.py ~/powerline-zsh.py
fi

# Local folder setup
mkdir -p ~/Sites/

# Install Python tools
pip install --user black pylint

# Create profile directory and download color scheme
mkdir -p ~/.iterm2_profile && wget -O ~/.iterm2_profile/Ayu\ Mirage.itermcolors "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Ayu%20Mirage.itermcolors"

# Run AppleScript to apply iTerm2 settings
osascript "$(dirname "$0")/iterm2-setup.applescript"

# Modify ~/.zshrc with aliases and settings
cat <<EOT >> ~/.zshrc

# Load Homebrew
eval "\$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Powerline
function _update_ps1() {
  export PROMPT="\$(~/powerline-zsh.py \$?)"
}
precmd() {
  _update_ps1
}

# Homebrew Alias
alias brewu='brew update && brew upgrade && brew cleanup'

# Docker Aliases
alias docker-compose="docker compose"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcl="docker-compose exec --user \$(id -u):\$(id -g) web /bin/bash"
alias dcdebug="docker-compose down && docker-compose run --service-ports web"
alias dclc="dockerlogin"
alias dwp="docker_wpcli"

docker_wpcli() {
  if ! [[ -d ./wp-includes && -d ./wp-admin && -d ./wp-content ]]; then
    echo 'Not in WordPress project.'
    return 1
  fi

  CONTAINERS_ACTIVE=\$(docker ps | grep \${PWD##*/} | wc -l)
  if [ \$CONTAINERS_ACTIVE -lt 2 ]; then
    echo 'Start WordPress and Database containers first.'
    return 1
  fi

  COUNT=\$(docker ps -a | grep wp_cli | wc -l)
  if [ \$COUNT -gt 0 ]; then
    echo 'Recreating wp_cli container...'
    docker rm wp_cli
  fi

  ARGS="\${@:-"--info"}"
  docker-compose run --name wp_cli --rm wp_cli "\$ARGS"
}

# Terminal Aliases
alias cat='bat'
alias l='eza --long --header -g -a --classify'

# Python
alias python=\$(which python3)
alias pip=\$(which pip3)

EOT
