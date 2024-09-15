prompt "Would you like to install kanata (keymapper)?"
(
  FILENAME="Karabiner-DriverKit-VirtualHIDDevice-3.1.0.pkg"
  cd /tmp
  curl -JOL https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/raw/main/dist/$FILENAME
  sudo installer -pkg $FILENAME -target $HOME
  rm -rf $FILENAME
  /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
)

cargo install kanata
