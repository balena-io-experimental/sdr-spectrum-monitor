# Run OpenWebRX on balena to remotely monitor local radio spectrum

Combine a Raspberry Pi and an inexpensive SDR (Software-Defined Radio) dongle to create a remote monitoring device that you can place anywhere in the world (with internet access) to view the surrounding radio spectrum and stream audio from some of the detected signals. See the full [project tutorial](https://www.balena.io/blog/running-openwebrx-on-balena-to-remotely-monitor-local-radio-spectrum/) on our blog!

To learn more about OpenWebRX visit the [project site](https://sdr.hu/openwebrx) or check out their [GitHub repository](https://github.com/ha7ilm/openwebrx).

## Hardware requirements
You’ll need the following hardware:

* A Raspberry Pi, preferably a 3B+ or 4, but nothing less than a Raspberry Pi 2.
* A 16GB microSD card or larger (We recommend using SanDisk Extreme Pro for best results)
* An RTL-SDR based USB dongle. Good results have been obtained using the RTL-SDR.COM V3 but any dongle based on this chip will do. They range from $15 - $30 (beware of potentially poor performance from very cheap dongles!)
* An antenna suitable for picking up signals in the frequency range you want to monitor with the appropriate connector for your SDR dongle. (Some of the dongle kits linked above include an antenna that reasonably covers many frequencies.)

## Setting up

* Log into your balenaCloud account and create a new application from the dashboard.
* Add a device and download the balenaOS disk image from the dashboard. You can enter your WiFi details at this point if you wish so that your device can connect to the internet once it boots up.
* Flash your SD card (we recommend using balenaEtcher) with the balenaOS image, insert it into your Raspberry Pi and power it up. After a minute or so, it should connect to the internet and show up on your balenaCloud dashboard.

Once the device is connected and showing on the dashboard, you can deploy the project code in this repository.

* Download or clone this project to your local computer
* Use the balenaCLI to push the application to your device

To access your spectrum monitor on your local network, enter the IP address (found on your device dashboard) followed by :8073 (the default port number.) If everything is running correctly you should see a waterfall display and a play button. Click on the play button to start monitoring the default spectrum centered at 144.25 MHz. (You can change the port and the center frequency using environment variables in the balenaCloud dashboard as described below.)

* ORX_WEB_PORT - port for Openwebrx (defaults to 8073. If you set to 80, it will use a secure websocket and you should enable the balena public URL feature, granting access to anyone who you provide with the URL.)
* ORX_SAMP_RATE - sampling rate (defaults to 2400000 which works well for RTL-SDR)
* ORX_CENTER_FREQ - Center frequency (defaults to 144250000 which is 144.25MHz)
* ORX_MAX_CLIENTS - Maximum number of clients that can connect at once (default is 20)
* ORX_NAME - Name to display on your spectrum page
* ORX_LOCATION - Location to display on your spectrum page
* ORX_SDRHU_KEY - If you have registered on sdr.hu and have a key, you can set it here and your receiver will be shared.

The waterfall display shows any detected signals in a highlighted color. Click on a signal to listen to the audio, if available. You may need to try switching the type of demodulation (such as AM, FM, etc…) using the buttons on the lower right of the display to hear proper audio.

The RTL-SDR has a bandwidth of 2.4 MHz so that is the maximum amount of spectrum you can view at one time. You can set a “center frequency” which will be the mid point of the display with 1.2 MHz of spectrum viewable on either side. To change the center frequency, add or modify the device variable named ORX_CENTER_FREQ with a numeric value in Hz containing no commas or decimals. For instance, if you want a center frequency at 121.45 MHz you would enter 121450000 for the value.

