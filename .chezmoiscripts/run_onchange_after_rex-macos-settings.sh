#!/bin/bash
# Rex for Mac settings from com.superlogical.rex.
# Window frames, the open session, Sparkle, and the sidebar's collapsed
# state are left out. Those change as you use the app.

if [ "$(uname)" != "Darwin" ]; then
	exit 0
fi

domain=com.superlogical.rex

defaults write "$domain" Workspace.activePaneBorderColor -string blue
defaults write "$domain" Workspace.activePaneBorderOpacity -float 0.2492644230769231
defaults write "$domain" Workspace.activePaneBorderTransition -string fade
defaults write "$domain" Workspace.appIconVisibility -string dockAndMenuBar
defaults write "$domain" Workspace.cursorShader -string blaze
defaults write "$domain" Workspace.cursorShadersEnabled -bool true
defaults write "$domain" Workspace.darkThemeID -string abyssal-trench
defaults write "$domain" Workspace.focusFollowsMouse -bool false
defaults write "$domain" Workspace.inactivePaneFadeMode -string styling
defaults write "$domain" Workspace.interfaceStyle -string blendTheme
defaults write "$domain" Workspace.lightThemeID -string merino-light
defaults write "$domain" Workspace.paneDensity -string compact
defaults write "$domain" Workspace.paneHeaderVisibility -string onHover
defaults write "$domain" Workspace.showsActivePaneBorder -bool true
defaults write "$domain" Workspace.showsPaneHeaders -bool false
defaults write "$domain" Workspace.sidebarPosition -string left
defaults write "$domain" Workspace.sidebarShowsActivity -bool false
defaults write "$domain" Workspace.tabIconTintMode -string off
defaults write "$domain" Workspace.tabStyle -string vertical
defaults write "$domain" Workspace.terminalCopyOnSelect -bool true
defaults write "$domain" Workspace.terminalOptionKeyBehavior -string actsAsAlt
defaults write "$domain" Workspace.terminalSelectionBackground -string theme
defaults write "$domain" Workspace.terminalSelectionRoundedCorners -bool true
defaults write "$domain" Workspace.terminalSmoothScrolling -bool true
defaults write "$domain" Workspace.usesPaneGlass -bool false
defaults write "$domain" Workspace.usesStandardInactiveWindowPaneStyles -bool true
defaults write "$domain" rex.agents.names-sessions -bool true
