source "$HOME/.setup/utils/constants.sh"

echo "Performing healthcheck..."

# Make the temp directory
rm -rf $DIR_TEMP
mkdir $DIR_TEMP

# Generate tmp files that keep track of all common installers
for SYSTEM in "${SYSTEMS[@]}"; do
  DIR_INSTALLER="$DIR_INSTALLERS/$SYSTEM"
  OUTPUT="$DIR_TEMP/~compare-$SYSTEM.tmp"
  ls -1 "$DIR_INSTALLER/common" > $OUTPUT
done
unset SYSTEM

# Compare common installers to ensure there are no discrepancies
COUNTER=0
for SYSTEM in "${SYSTEMS[@]}"; do
  # Increment counter
  COUNTER=$((COUNTER + 1))

  # Skip first occurrence
  if [[ $COUNTER -eq 1 ]]; then
    continue
  fi

  # Now we are guaranteed to have a previous and current
  CURRENT="$DIR_TEMP/~compare-${SYSTEMS[$COUNTER-1]}.tmp"
  PREVIOUS="$DIR_TEMP/~compare-${SYSTEMS[$COUNTER-2]}.tmp"

  # Do the actual comparison
  OUTPUT="$DIR_TEMP/~comparison-log.tmp"
  diff -y -W 40 $PREVIOUS $CURRENT > $OUTPUT
  if [[ $? -ne 0 ]]; then
    echo ""
    echo "WARNING: ${SYSTEMS[$COUNTER-2]} & ${SYSTEMS[$COUNTER-1]} discrepancy found"
    echo ""
    cat $OUTPUT
    echo ""
  fi
done
unset SYSTEM
unset COUNTER

# TODO: check that all installer scripts are exucutable

# # Clean up temp folder
rm -rf $DIR_TEMP

echo "Done."
