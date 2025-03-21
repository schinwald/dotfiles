#! /bin/zsh

alias yii='PGPASSWORD=nautical && createdb -h 127.0.0.1 -p 5432 -U nautical ingestion -w'
alias yis='yarn db:migrate'
alias yid='yis && yarn dev'
