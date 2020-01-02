#!/bin/bash

#Update OpenWebRX websocket if we are on port 80 (assuming public https URL)
if [[ $ORX_WEB_PORT == "80" ]]; then
  echo 'install.sh: Changing ws:// to wss://'
  cd /usr/src/app/openwebrx
  sed -i 's+ws://+wss://+g' openwebrx.py
  cd htdocs
  sed -i 's+ws://+wss://+g' openwebrx.js
else
  echo 'install.sh: Changing wss:// to ws://'
  cd /usr/src/app/openwebrx
  sed -i 's+wss://+ws://+g' openwebrx.py
  cd htdocs
  sed -i 's+wss://+ws://+g' openwebrx.js
fi

# run with our custom config file
cd /usr/src/app/openwebrx
python openwebrx.py config_alt
