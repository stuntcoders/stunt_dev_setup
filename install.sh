#!/bin/bash

xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install caskroom/cask/brew-cask

brew tap homebrew/bundle
brew bundle

# Remove apps from Dock
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
dockutil --remove 'iTunes' --allhomes
dockutil --remove 'iBooks' --allhomes
dockutil --remove 'App Store' --allhomes
dockutil --remove 'System Preferences' --allhomes
dockutil --remove 'Keynote' --allhomes
dockutil --remove 'Pages' --allhomes
dockutil --remove 'Numbers' --allhomes
dockutil --remove 'Podcasts' --allhomes
dockutil --remove 'TV' --allhomes

# Add apps to Dock
dockutil --add '/Applications/Mattermost.app' --position 1 --allhomes
dockutil --add '/Applications/Google Chrome.app' --position 2 --allhomes
dockutil --add '/Applications/Visual Studio Code.app' --position 3 --allhomes
dockutil --add '/Applications/Sublime Text.app' --position 4 --allhomes
dockutil --add '/Applications/iTerm.app' --position 5 --allhomes

# Install Grunt and Sass
npm install --global grunt-cli
sudo gem install sass

# Install yadr
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"
cd ~/.yadr/ && rake update
sed -i '' -e 's/skwp/agnoster/g' ~/.yadr/zsh/theme.zsh

# Install theme
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sed -i '' -e 's/ZSH_THEME="robbyrussel"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Fix zsh security issues
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# Add aliases
cat <<EOT >> ~/.zshrc
# Homebrew
alias brewu='brew update && brew upgrade && brew cleanup && brew prune && brew doctor'

# Vagrant
alias vup='vagrant up'
alias vd='vagrant suspend'
alias vssh='vagrant ssh'

# Install Vagrant plugins
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-faster

# Fabric
alias fsd='fab staging deploy'
alias fpd='fab production deploy'

# Terminal
alias cat='bat'
alias l='exa --long --header -g -a --classify'
EOT

# Fix zsh Insecure completion-dependent directories issues
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# Local files, folders and scripts setup
mkdir ~/Sites/
sudo easy_install pip
pip install -Iv fabric==1.14.1

# Rbenv
brew install rbenv
rbenv install 2.7.1
rbenv global 2.7.1

# Install Capistrano
gem install capistrano
