<h1>Raspberry-Sagan</h1>
<h3>(Still Buggy) Instructions for turning a base Raspberry Pi image into an updated Cuberider Pi-Sagan</h3>
<p>Get Raspbian Buster: https://downloads.raspberrypi.org/raspbian/images/raspbian-2020-02-07/</p>
<p>(Tested with 2020-02-05 Release)</p>
<p>Unzip and write the image to a micro-SD card</p>
<p>Boot your Raspberry Pi from the SD card and connect to wifi</p>
<p>(It may show a blue screen with "Resized root filesystem, rebooting in 5 seconds" on the first bootup This is okay.)</p>
<p>sudo git-clone https://github.com/a-v-e-s/sagan-control-daemon /opt/sagan-control-daemon</p>
<p>cd /opt/sagan-control-daemon</p>
<p>sudo bash install.sh</p>
<p>sudo shutdown -r now</p>