#!/bin/bash

apt update
until apt install mongodb -y; do
        sleep 1
done
systemctl start mongodb
systemctl enable mongodb
