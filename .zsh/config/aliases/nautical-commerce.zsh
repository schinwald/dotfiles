#! /bin/zsh

# +---------------------------+
# | NAUTICAL-COMMERCE ALIASES |
# ==============================
# nautical-api
NAUTICAL_API_PATH="~/Projects/nautical-api"
alias api-exec='$NAUTICAL_API_PATH/nautical-execute'
alias api-db-main='$HOME/.config/gcloud/cloud-sql-proxy -p 5433 nautical-commerce:us-central1:nautical-dev-shared-us'

# storefront, dashboard, checkout, etc
alias ys='yarn install && yarn generate && yarn dev'
