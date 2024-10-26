#!/bin/bash

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

