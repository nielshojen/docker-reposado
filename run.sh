#!/bin/bash

/usr/sbin/nginx

if [[ ${LOCAL_URL} ]]; then
  /bin/echo "Setting LocalCatalogURLBase to ${LOCAL_URL}"
  LOCALCATALOGURLBASE=$'\n  <key>LocalCatalogURLBase</key>\n  <string>'${LOCAL_URL}'</string>'
fi

if [[ ${MIN_OS_CATALOGS} ]]; then
  /bin/echo "Setting AppleCatalogURLs to 10.${MIN_OS_CATALOGS}+"
  CATALOGS=$'\n  <key>AppleCatalogURLs</key>\n  <array>'
  if [[ ${MIN_OS_CATALOGS} -le 6 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/index.sucatalog</string>\n    <string>http://swscan.apple.com/content/catalogs/index-1.sucatalog</string>\n    <string>http://swscan.apple.com/content/catalogs/others/index-leopard.merged-1.sucatalog</string>\n    <string>http://swscan.apple.com/content/catalogs/others/index-leopard-snowleopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 7 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 8 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 9 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 10 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 11 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 12 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 13 ]]; then
    CATALOGS+=$'\n    <string>http://swscan.apple.com/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 14 ]]; then
    CATALOGS+=$'\n    <string>https://swscan.apple.com/content/catalogs/others/index-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  if [[ ${MIN_OS_CATALOGS} -le 15 ]]; then
    CATALOGS+=$'\n    <string>https://swscan.apple.com/content/catalogs/others/index-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog</string>'
  fi
  CATALOGS+=$'\n  </array>'
fi

/bin/cat <<EOF > /reposado/code//preferences.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>${LOCALCATALOGURLBASE}
  <key>UpdatesMetadataDir</key>
  <string>/reposado/metadata</string>
  <key>UpdatesRootDir</key>
  <string>/reposado/html</string>${CATALOGS}
</dict>
</plist>
EOF

for SCRIPT in $(/usr/bin/find /reposado/scripts -type f); do
	/bin/bash $SCRIPT
done

sleep infinity
