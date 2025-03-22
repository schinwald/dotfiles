#! /bin/zsh

NAUTICAL_API_PATH="~/Projects/nautical-api"
alias nauticalexecute='$NAUTICAL_API_PATH/nauticalexecute'
alias gcloudmain='cloud-sql-proxy --run-connection-test -p 5433 nautical-commerce:us-central1:nautical-dev-shared-us'
alias tests=runtests

runtests () {
	docker-compose run --rm api poetry run pytest -vv -n auto -m "not integration" --reuse-db $@
}
