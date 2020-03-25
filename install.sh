#!/bin/sh

#Fetch and build rtl-sdr
echo "***** building rtl-sdr *****"
cd /usr/src/app
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
make
sudo make install
sudo ldconfig
cd ../..
echo "***** finished building rtl-sdr *****"

#Disable the DVB-T driver, which would prevent the rtl_sdr tool from accessing the stick
#(if you want to use it for DVB-T reception later, you should undo this change):
echo "***** disabling DVB-T driver *****"
sudo bash -c 'echo -e "\n# for RTL-SDR:\nblacklist dvb_usb_rtl28xxu\n" >> /etc/modprobe.d/blacklist.conf'

#Disable the problematic kernel module for the current session:
sudo rmmod dvb_usb_rtl28xxu 

#Download OpenWebRX and libcsdr
git clone https://github.com/simonyiszk/openwebrx.git
git clone https://github.com/simonyiszk/csdr.git

#Apply unmerged changes from this branch: https://github.com/jketterl/csdr/tree/fix_arm_slow_timer
#Fixes 30 second start delay
cp -f /tmp/Makefile /usr/src/app/csdr/Makefile
cp -f /tmp/fft_fftw.c /usr/src/app/csdr/fft_fftw.c
cp -f /tmp/fft_fftw.h /usr/src/app/csdr/fft_fftw.h

cp -f /tmp/sdrhu.py /usr/src/app/openwebrx/sdrhu.py

#Compile libcsdr (which is a dependency of OpenWebRX)
echo "***** compiling libcsdr *****"
cd csdr
make
sudo make install
