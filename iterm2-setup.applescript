tell application "iTerm"
    activate
    tell current session of current window
        -- Set font
        set myFont to "Source Code Pro"
        tell application "System Events"
            tell process "iTerm2"
                delay 1
                click menu item "Profiles" of menu "iTerm2" of menu bar 1
                delay 1
                click menu item "Text" of menu "Profiles" of menu bar 1
                delay 1
                click pop up button 1 of group 1 of window 1
                delay 1
                keystroke myFont
                keystroke return
            end tell
        end tell

        -- Import and apply Ayu Mirage colors
        tell application "System Events"
            tell process "iTerm2"
                delay 1
                click menu item "Profiles" of menu "iTerm2" of menu bar 1
                delay 1
                click menu item "Colors" of menu "Profiles" of menu bar 1
                delay 1
                click button "Color Presets…" of group 1 of window 1
                delay 1
