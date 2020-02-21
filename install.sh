#!/usr/bin/env bash

set -e
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove
sudo apt -y install libi2c-dev libffi-dev hostapd dnsmasq zip
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

# Set up virtual environment
pip3 install -r requirements.txt
sudo mkdir env
sudo python3 -m venv --system-site-packages env
#source env/bin/activate

user="pi"
if ! id ${user} >/dev/null 2>&1; then
    useradd -r ${user}
fi

if [ ! -d sandbox ]; then
    sudo mkdir sandbox
fi
sudo chown ${user}:${user} sandbox

if [ ! -e leds ]; then
    sudo mkfifo leds
fi
sudo chown ${user}:${user} leds

if [ ! -e telemetry ]; then
    sudo mkfifo telemetry
fi
sudo chown ${user}:${user} telemetry

touch enabled

# Set up start up script
sudo cp rc_local.sh /etc/rc.local
sudo chmod +x /etc/rc.local
sudo chmod +x run.sh
sudo chmod +x run-notifier.sh

sudo cp hostapd.conf /etc/hostapd/
sudo cp init.d_hostapd /etc/init.d/hostapd

sudo cp dnsmasq.conf /etc/
sudo cp hosts /etc/

sudo cp interfaces-ap /etc/network/interfaces.d/

sudo systemctl daemon-reload
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl unmask dnsmasq
sudo systemctl enable dnsmasq
sudo systemctl start hostapd
sudo systemctl start dnsmasq
