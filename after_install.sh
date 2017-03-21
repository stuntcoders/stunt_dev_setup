#!/bin/bash

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

dockutil --add '/Applications/Google Chrome.app'/ --position 2 --allhomes
dockutil --add '/Applications/PhpStorm.app' --position 3 --allhomes
dockutil --add '/Applications/Sublime Text.app'/ --position 4 --allhomes
dockutil --add '/Applications/iTerm.app' --position 5 --allhomes
