source "$HOME/.setup/utils/constants.sh"

# +-----------+
# | INSTALLER |
# =============

# Check what installer to use
DIR_INSTALLER=""

# Setup Linux (assumes Ubuntu currently)
if [ $OS = "Linux" ]; then
  DIR_INSTALLER="$DIR_INSTALLERS/ubuntu"
# Setup MacOS
elif [ $OS = "Darwin" ]; then
  DIR_INSTALLER="$DIR_INSTALLERS/macos"
fi

# Initialize the environment for installation
./utils/runner.sh $DIR_INSTALLER/init.sh

# Install programming
for FILE in $DIR_INSTALLER/programming/*; do
  ./utils/runner.sh $FILE
done
unset FILE

# Install common
for FILE in $DIR_INSTALLER/common/*; do
  ./utils/runner.sh $FILE
done
unset FILE

# Install ricing
for FILE in $DIR_INSTALLER/ricing/*; do
  ./utils/runner.sh $FILE
done
unset FILE

# Install extras
for FILE in $DIR_INSTALLER/extras/*; do
  ./utils/runner.sh $FILE
done
unset FILE
