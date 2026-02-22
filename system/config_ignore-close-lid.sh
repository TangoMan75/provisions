#!/bin/bash

# Script to ignore lid close events and prevent system suspension
# This prevents the laptop from suspending when the lid is closed

echo "Configuring system to ignore lid close events..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
fi

# Create logind configuration directory if it doesn't exist
mkdir -p /etc/systemd/logind.conf.d

# Create configuration to ignore lid close using sed
CONFIG_FILE="/etc/systemd/logind.conf.d/ignore-lid-close.conf"

# Create the file if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    echo "[Login]" > "$CONFIG_FILE"
fi

# Use sed to add/update the configuration lines
for setting in "HandleLidSwitch=ignore" "HandleLidSwitchExternalPower=ignore" "HandleLidSwitchDocked=ignore"; do
    key=$(echo "$setting" | cut -d'=' -f1)
    value=$(echo "$setting" | cut -d'=' -f2)
    
    # Check if the setting exists (commented or uncommented)
    if grep -q "^[# ]*$key=" "$CONFIG_FILE"; then
        # Replace existing setting (commented or uncommented)
        sed -i "s/^[# ]*$key=.*/$key=$value/" "$CONFIG_FILE"
    else
        # Add new setting after [Login] section
        sed -i "/^\[Login\]/a $key=$value" "$CONFIG_FILE"
    fi
done

echo "Configuration file created: /etc/systemd/logind.conf.d/ignore-lid-close.conf"

# Restart systemd-logind service to apply changes
echo "Restarting systemd-logind service..."
systemctl restart systemd-logind

# Verify the configuration
echo "Verifying configuration..."
if systemctl show systemd-logind -p HandleLidSwitch | grep -q "ignore"; then
    echo "✓ Lid close events are now being ignored"
    echo "✓ System will not suspend when lid is closed"
else
    echo "⚠ Configuration may not have been applied correctly"
    echo "Please check: /etc/systemd/logind.conf.d/ignore-lid-close.conf"
fi

echo ""
echo "Setup complete! The system will no longer suspend when the lid is closed."
echo "To revert this change:"
echo "  sudo rm /etc/systemd/logind.conf.d/ignore-lid-close.conf"
echo "  sudo systemctl restart systemd-logind"
