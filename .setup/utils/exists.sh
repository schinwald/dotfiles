# Check if a command already exists
exists() {
  command -v "$1" &> /dev/null
}

export -f exists
