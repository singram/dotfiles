#!/bin/bash

# Update repos
apt-get update

# Useful packages
apt-get install net-tools clusterssh curl dstat htop iftop nmap sshfs sysstat tmux jq 

# Python
apt-get install python3-pip pkg-config libicu-dev
pip install pyicu csvkit

# Build tools
#apt-get install dconf-tools build-essential

# Libraries
#apt-get install libaio1 libffi-dev libgdbm-dev libgtk-3-dev libgtk2.0-dev libjpeg62 libreadline6-dev libsqlite3-dev libssl-dev libxml2-dev libxslt1-dev libyaml-dev zlib1g-dev