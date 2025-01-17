#! /bin/zsh

# +---------------------------+
# | NAUTICAL-COMMERCE ALIASES |
# ==============================
# nautical-api
NAUTICAL_API_PATH="~/Projects/nautical-api"
alias api-exec='$NAUTICAL_API_PATH/nauticalexecute'
alias api-db-main='$HOME/.config/gcloud/cloud-sql-proxy -p 5433 nautical-commerce:us-central1:nautical-dev-shared-us'

# ingestion
export yii='PGPASSWORD=nautical && createdb -h 127.0.0.1 -p 5432 -U nautical ingestion -w'
export yis='yarn db:migrate'
export yid='yis && yarn dev'

# storefront, dashboard, checkout, etc
alias ys='yarn install && yarn generate'
alias yc='ys && yarn typecheck'
alias yd='ys && yarn dev'
alias yus='yarn add @nautical-commerce/graphql-schema@next'
