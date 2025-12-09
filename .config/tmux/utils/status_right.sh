#!/usr/bin/env bash

GIT_BRANCH="  $(git branch --show-current) "
K8S_CONTEXT=$(kubectl config current-context 2> /dev/null)

ENTRIES=(
  "$GIT_BRANCH"
  "$K8S_CONTEXT"
)

DELIMITER="|"

OUT=""
for ITEM in "${ENTRIES[@]}"; do
  [[ -z "$ITEM" ]] && continue
  if [[ -n "$OUT" ]]; then
    OUT+="$DELIMITER"
  fi
  OUT+="$ITEM"
done

echo "$OUT"
