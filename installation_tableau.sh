#!/bin/bash

# Define variables
TABLEAU_VERSION="2021-4-0"
TABLEAU_DOWNLOAD_URL="https://downloads.tableau.com/esdalt/${TABLEAU_VERSION}/tableau-server-${TABLEAU_VERSION}_amd64.deb"

# Download Tableau Server
echo "Downloading Tableau Server..."
wget -q -O tableau-server.deb "$TABLEAU_DOWNLOAD_URL"

# Install Tableau Server
echo "Installing Tableau Server..."
sudo dpkg -i tableau-server.deb

# Start Tableau Server
echo "Starting Tableau Server..."
sudo tableau-server initialize
sudo tableau-server start

# Wait for Tableau Server to start
echo "Waiting for Tableau Server to start..."
sleep 60 # Adjust the sleep time as needed based on server startup time

# Test if Tableau Server has booted up successfully
if sudo tableau-server status | grep -q "Tableau Server is running"; then
    echo "Tableau Server has started successfully."
    exit 0
else
    echo "Error: Tableau Server failed to start."
    exit 1
fi
