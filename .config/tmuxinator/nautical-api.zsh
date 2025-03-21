#! /bin/zsh

NAUTICAL_API_PATH="~/Projects/nautical-api"
alias api-exec='$NAUTICAL_API_PATH/nauticalexecute'
alias api-db-main='cloud-sql-proxy --run-connection-test -p 5433 nautical-commerce:us-central1:nautical-dev-shared-us'
