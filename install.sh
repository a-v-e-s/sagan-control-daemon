#!/usr/bin/env bash

set -e
sudo apt -y install hostapd dnsmasq zip &> /dev/null
sudo systemctl disable hostapd &> /dev/null
sudo systemctl disable dnsmasq &> /dev/null

# Set up virtual environment
pip install -r requirements.txt
mkdir env
python3 -m venv --system-site-packages env
source env/bin/activate

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

# Set up start up script
sudo cp rc_local.sh /etc/rc.local
sudo chmod +x /etc/rc.local
sudo chmod +x run.sh
sudo chmod +x run-notifier.sh

sudo cp hostapd.conf /etc/hostapd/
sudo cp init.d_hostapd /etc/init.d/hostapd

sudo cp dnsmasq.conf /etc/
sudo cp hosts /etc/

sudo systemctl daemon-reload