# Install node
prompt "Would you like to install node?"
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell

# Install bun
npm install -g bun

# Install commit citizen
npm install -g commitizen

# Install zx
npm install -g zx

# Install ntl
npm install -g ntl
