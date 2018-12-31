#!/bin/bash

if [[ $LOCAL_URL ]]; then

/bin/cat <<EOF > /reposado/code/preferences.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>LocalCatalogURLBase</key>
  <string>${LOCAL_URL}</string>
  <key>UpdatesMetadataDir</key>
  <string>/reposado/metadata</string>
  <key>UpdatesRootDir</key>
  <string>/reposado/html</string>
</dict>
</plist>
EOF

fi

for SCRIPT in $(/usr/bin/find /reposado/scripts -type f); do
	/bin/bash $SCRIPT
done

sleep infinity
