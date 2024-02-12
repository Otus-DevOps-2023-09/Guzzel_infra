#!/bin/bash

apt-get update
apt install mongodb -y
systemctl start mongodb
systemctl enable mongodb
