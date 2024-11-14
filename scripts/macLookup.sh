#!/bin/bash
"""
=============================================================================
File:           macLookup.sh
Purpose:        A command-line tool that identifies the vendor/manufacturer
               of network interface cards based on their MAC address prefix.
               Uses the macvendorlookup.com API to perform the lookup.

How to run:     ./macLookup.sh [-j] [MAC]
               Options:
                   -j: Display full JSON response
                   MAC: First 6 characters of MAC address (XX:XX:XX or XXXXXX)
               Example: 
                   ./macLookup.sh -j 00:50:56
                   ./macLookup.sh 005056

Dependencies:   - curl
               - jq (for JSON parsing)
               - Internet connection for API access

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2023-07-14
Last Updated:   2023-07-14
Version:        1.0.0

Change History:
   1.0.0 (2023-07-14) - Initial release
       - Basic MAC vendor lookup functionality
       - Support for both XX:XX:XX and XXXXXX formats
       - Optional JSON output display (-j flag)
       - Interactive mode when no MAC provided
       - Integration with macvendorlookup.com API v2

License:        MIT License
               Copyright (c) 2024 Tom Kinsella
               See LICENSE file for full license text

Notes:
   - Requires valid MAC address prefix (first 6 characters)
   - Requires internet connection to access API
   - Rate limits may apply from API provider
=============================================================================
"""

# Initialize variables
show_json=false
mac_input=""

# Process command line arguments
while getopts "j" opt; do
  case $opt in
    j)
      show_json=true
      ;;
    \?)
      echo "Usage: $0 [-j] (optional: -j to show JSON output) [MAC input]"
      exit 1
      ;;
  esac
done

# Shift the command line arguments
shift $((OPTIND-1))

# Check if MAC input is provided as an argument
if [ $# -eq 1 ]; then
  mac_input="$1"
fi

# If MAC input is not provided, ask the user for it
if [ -z "$mac_input" ]; then
  read -p "Enter the first 6 characters of the MAC address (in XX:XX:XX or XXXXXX format): " mac_input
fi

# Remove any ":" from the input
mac_input_cleaned=$(echo "$mac_input" | tr -d ':')

# Construct the API URL with the cleaned MAC address
api_url="https://www.macvendorlookup.com/api/v2/$mac_input_cleaned"

# Use `curl` to fetch the JSON data from the API and store it in a variable
mac_vendor_info=$(curl -s "$api_url")

# Extract the company name from the JSON response
company=$(echo "$mac_vendor_info" | jq -r '.[0].company')

# Display the MAC address and company name
echo "MAC Address: $mac_input"
echo "Company: $company"

# Display JSON output if the flag is enabled
if [ "$show_json" = true ]; then
  echo "JSON Output:"
  echo "$mac_vendor_info"
fi

