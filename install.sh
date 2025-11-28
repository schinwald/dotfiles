/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install github cli
brew install gh
gh auth login

cd ~/
gh repo clone schinwald/notes

cd ~/
git clone --bare git@github.com:schinwald/dotfiles.git $HOME/.dotfiles
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
df checkout
df status

# Install browsers
brew install --cask brave-browser
brew install --cask firefox
brew install --cask arc

brew install mise
mise install

brew install ghostty
brew install starship
brew install antidote
brew install tmux
brew install tmuxinator
brew install beekeeper-studio
brew install --cask orbstack
brew install --cask raycast
brew install --cask obsidian
brew install --cask bitwarden
brew install --cask balenaetcher
brew install --cask discord
brew install jc
brew install zsh-autosuggestion

brew install git-graph
brew install postgresql
brew services restart postgresql
brew install kubernetes-cli

brew install --cask redis-insight
brew install --cask godot-mono

# with aerospace, you have to launch it from gui (do you??)
# gh is in installer section so it is duplicated
#
# kanata requires an install of https://karabiner-elements.pqrs.org/
# follow instructions in docs
# then exiting it in the tray icon
#
# raycast needs some manual setup
# https://manual.raycast.com/hotkey
