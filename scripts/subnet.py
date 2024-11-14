#!/usr/bin/env python3
"""
=============================================================================
File:           subnet.py
Purpose:        A network utility that performs subnet calculations based on
               CIDR notation or netmask input. Provides comprehensive subnet
               information including IP ranges, host counts, and decimal
               conversions in both human-readable and JSON formats.

How to run:     python subnet.py [CIDR/netmask]
               Examples:
                   python subnet.py 192.168.1.0/24
                   python subnet.py 255.255.255.0
               If no argument provided, script will prompt for input.

Dependencies:   Python 3.6+
               - ipaddress
               - sys
               - datetime
               - json

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2021-12-04
Last Updated:   2021-12-04
Version:        1.0.0

Change History:
   1.0.0 (2021-12-04) - Initial release
       - Support for both CIDR and netmask input formats
       - Comprehensive subnet calculations including:
           * Network/Broadcast addresses
           * Total/Usable host counts
           * Decimal IP conversions
           * Wildcard bits
       - Dual output formats:
           * Human-readable table
           * Formatted JSON
       - Input validation and error handling
       - Interactive mode when no arguments provided
       - Timestamp inclusion in output

License:        MIT License
               Copyright (c) 2024 Tom Kinsella
               See LICENSE file for full license text

Notes:
   - Supports IPv4 addresses only
   - All calculations use the ipaddress module for accuracy
   - Assumes input is either CIDR notation or dotted decimal netmask
   - Network and broadcast addresses are included in total host count
=============================================================================
"""

import ipaddress
import sys
import datetime
import json

# Function to calculate subnet information
def calculate_subnet_info(input_str):
    try:
        # Try parsing as a CIDR subnet
        subnet = ipaddress.IPv4Network(input_str, strict=False)
        is_subnet = True
    except ValueError:
        try:
            # Try parsing as a netmask
            netmask = ipaddress.IPv4Address(input_str)
            is_subnet = False
        except ValueError:
            print("Invalid input. Please enter a valid CIDR subnet or netmask.")
            exit(1)

    if is_subnet:
        netmask = subnet.netmask
    else:
        subnet = ipaddress.IPv4Network(f"0.0.0.0/{netmask}", strict=False)

    first_ip_decimal = int(subnet.network_address)
    last_ip_decimal = int(subnet.broadcast_address)
    total_hosts = subnet.num_addresses
    usable_hosts = total_hosts - 2

    # Prepare data in a dictionary
    subnet_info = {
        "Date and Time": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "CIDR Subnet": str(subnet),
        "Netmask": str(netmask),
        "Wildcard Bits": str(subnet.hostmask),
        "First IP": str(subnet.network_address),
        "First IP (Decimal)": first_ip_decimal,
        "Last IP": str(subnet.broadcast_address),
        "Last IP (Decimal)": last_ip_decimal,
        "Total Hosts": total_hosts,
        "Usable Hosts": usable_hosts,
    }

    return subnet_info

# Check if an input argument is provided
if len(sys.argv) > 1:
    input_arg = sys.argv[1]
else:
    # If not provided, prompt the user for the input
    input_arg = input("Enter a CIDR subnet or netmask: ")

# Calculate and report the information
subnet_info = calculate_subnet_info(input_arg)

# Print information in a table format
print("\nSubnet Information:")
for key, value in subnet_info.items():
    print(f"{key:<20}: {value}")

# Print information in formatted JSON output
json_output = json.dumps(subnet_info, indent=4)
print("\nJSON Output:")
print(json_output)

