#!/usr/bin/env python3
"""
=============================================================================
File:           nmapFormat.py
Purpose:        Parses nmap scan output from stdin and converts it into a
               clean, formatted table using pandas. Extracts IP addresses,
               ports, protocols, states and services from nmap scan results.

How to run:     nmap [options] target | python nmap_parser.py
               Example:
               nmap -p- 192.168.1.0/24 | python nmap_parser.py 

Dependencies:   Python 3.6+
               - sys
               - re
               - pandas

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2017-03-27
Last Updated:   2017-03-27
Version:        1.0.0

Change History:
   1.0.0 (2017-03-27) - Initial release
       - Basic nmap output parsing functionality
       - Regular expression pattern matching for:
           * IP addresses
           * Port numbers
           * Protocols
           * Port states
           * Service names
       - Pandas DataFrame output formatting
       - stdin input processing

License:        MIT License
               Copyright (c) 2024 Tom Kinsella
               See LICENSE file for full license text

Notes:
   - Expects nmap output via stdin
   - Matches standard nmap output format
   - Uses pandas for clean table formatting
=============================================================================
"""

import sys
import re
import pandas as pd

def parse_nmap_output(nmap_output):
    pattern = re.compile(r'(\d+\.\d+\.\d+\.\d+).*?(\d+)/(\w+)\s+(\w+)\s+(\w+)')
    data = []

    for line in nmap_output:
        match = pattern.search(line)
        if match:
            ip, port, protocol, state, service = match.groups()
            data.append([ip, port, protocol, state, service])

    return data

def output_to_table(data):
    df = pd.DataFrame(data, columns=['IP', 'Port', 'Protocol', 'State', 'Service'])
    return df

# Read from stdin
nmap_output = sys.stdin.readlines()

parsed_data = parse_nmap_output(nmap_output)
table = output_to_table(parsed_data)
print(table)

