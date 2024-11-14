#!/bin/sh
"""
=============================================================================
File:           pingSweep.sh
Purpose:        A simple network scanning tool that performs a ping sweep of
               a specified IP range (1-254) to identify active hosts on a
               network. Uses parallel ping operations for faster scanning.

How to run:     ./pingSweep.sh [network_prefix]
               Example:
                   ./pingSweep.sh 192.168.1
               Network prefix should be first three octets of IPv4 address.

Dependencies:   - ping
               - cut
               - tr
               - seq

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2012-03-07
Last Updated:   2012-03-07
Version:        1.0.0

Change History:
   1.0.0 (2012-03-07) - Initial release
       - Basic ping sweep functionality
       - Parallel ping execution using background processes
       - Support for full Class C subnet scanning (1-254)
       - Simplified output showing only responding IP addresses
       - Basic input validation and usage instructions
       - Uses standard Unix/Linux tools (ping, cut, tr)

License:        MIT License
               Copyright (c) 2024 Tom Kinsella
               See LICENSE file for full license text

Notes:
   - Requires root/sudo privileges on some systems
   - Scans entire range 1-254 (Class C subnet)
   - May trigger IDS/IPS systems
   - Performance depends on network conditions
   - Uses parallel execution for faster results
=============================================================================
"""

#!/bin/sh

if [ "$1" == ""]
then
echo "You forgot an IP address!"
echo "Syntax: pingSweep 192.168.1"

for ip in $(seq 1 254); do
    ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done
