# Install homebrew
if ! exists "brew"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update brew
brew update
brew upgrade
