#!/usr/bin/env bash
set -euo pipefail

echo "🔐 Checking for existing GPG secret keys..."

KEY_ID=$(gpg --list-secret-keys --keyid-format=long \
  | awk '/^sec/{print $2}' \
  | cut -d'/' -f2 \
  | head -n1)

if [[ -z "${KEY_ID}" ]]; then
  echo "❌ No GPG secret key found."
  echo "👉 Run: gpg --full-generate-key"
  exit 1
fi

echo "✅ Using GPG key: $KEY_ID"

echo "📤 Exporting public key and adding to GitHub..."
gpg --armor --export "$KEY_ID" | gh gpg-key add -

echo "⚙️  Configuring git to sign commits..."
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo "🎉 Done!"
echo "👉 Verify at: https://github.com/settings/keys"
