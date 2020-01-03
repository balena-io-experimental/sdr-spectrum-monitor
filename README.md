# OpenWebRX running on balenaCloud

Environment variables - set on balenaCloud dashboard:

ORX_WEB_PORT - port for Openwebrx (defaults to 8073. If you set to 80, it will use a secure websocket)
ORX_SAMP_RATE - sampling rate (defaults to 2400000 which works well for RTL-SDR)
ORX_CENTER_FREQ - Center frequency (defaults to 144250000 which is 144.25MHz)
ORX_MAX_CLIENTS - Maximum number of clients that can connect at once (default is 20)
ORX_NAME - Name to display on your spectrum page
ORX_LOCATION - Location to display on your spectrum page

Project site: https://github.com/simonyiszk/openwebrx
