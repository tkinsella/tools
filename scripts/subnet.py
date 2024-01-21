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

