# Prompt for yes or no given a question
prompt() {
  while true; do
    read -p "$1 (Y/n)" -n 1 -r response
    echo ""

    if [[ $response =~ ^[Yy]$ ]] || [[ -z $response ]]; then
      break
    elif [[ $response =~ ^[Nn]$ ]]; then
      exit 0
    fi
  done
}

export -f prompt
