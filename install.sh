#!/bin/bash

xcode-select --install

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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

# Add apps to Dock
dockutil --add '/Applications/Mattermost.app' --position 1 --allhomes
dockutil --add '/Applications/Google Chrome.app' --position 2 --allhomes
dockutil --add '/Applications/Visual Studio Code.app' --position 3 --allhomes
dockutil --add '/Applications/Sublime Text.app' --position 4 --allhomes
dockutil --add '/Applications/iTerm.app' --position 5 --allhomes

# Install Grunt and Sass
npm install --global grunt-cli
sudo gem install sass

# Install powerline fonts
brew tap homebrew/cask-fonts
brew cask install font-source-code-pro

# Install yadr
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"
cd ~/.yadr/ && rake update
sed -i '' -e 's/skwp/agnoster/g' ~/.yadr/zsh/theme.zsh

# Install theme
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sed -i '' -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Add aliases
cat <<EOT >> ~/.yadr/zsh/aliases.zsh
# Homebrew
alias brewu='brew update && brew upgrade && brew cleanup && brew prune && brew doctor'

# Vagento
alias vup='vagrant up'
alias vd='vagrant suspend'
alias vssh='vagrant ssh'

# Fabric
alias fsd='fab staging deploy'
alias fpd='fab production deploy'

# Terminal
alias cat='bat'
alias l='exa --long --header -g -a --classify'
EOT
