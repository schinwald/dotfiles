# MacOS Guide

## Kanata

Open up the `kanata.plist` file and update the paths necessary.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.kanata</string>

    <key>ProgramArguments</key>
    <array>
        <string>{{ path to kanata }}</string>
        <string>-c</string>
        <string>{{ path to config }}</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/Library/Logs/Kanata/kanata.out.log</string>

    <key>StandardErrorPath</key>
    <string>/Library/Logs/Kanata/kanata.err.log</string>
</dict>
</plist>
```

Copy the plist to the system daemons folder. We can't create a symlink here for system access because in order for the daemon to run it needs to be owned by the root and isn't user controlled.

```bash
sudo cp com.schinwald.kanata.plist /Library/LaunchDaemons/
```

Bootstrap the plist to run it on startup.

```bash
sudo launchctl bootstrap system /Library/LaunchDaemons/com.schinwald.kanata.plist
```

You might have to specifically allow the executable kanata the permission for input monitoring (if you didn't get this GUI popup guiding you to do so already). To do this go to `Settings > Privacy & Security > Input Monitoring`, and click the + icon, navigate to the place your kanata executable is (should match the same path in the \*.plist above, ~/.cargo/bin/kanata), and add it.
