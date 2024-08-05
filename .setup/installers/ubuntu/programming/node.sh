# Install node
prompt "Would you like to install node?"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | PROFILE=/dev/null bash
# TODO: migrate to fnm for speed (make sure to skip shell)
# curl -fsSL https://fnm.vercel.app/install | bash

# Install bun
npm install -g bun

# Install commit citizen
npm install -g commitizen

# Install zx
npm install -g zx

# Install ntl
npm install -g ntl
