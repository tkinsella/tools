import ipaddress
import sys

# Function to calculate and report subnet information
def calculate_subnet_info(subnet):
    try:
        subnet = ipaddress.IPv4Network(subnet, strict=False)
    except ValueError:
        print("Invalid CIDR subnet format. Please use the format x.x.x.x/xx.")
        exit(1)

    print(f"CIDR Range: {subnet}")
    print(f"Netmask: {subnet.netmask}")
    print(f"Wildcard Bits: {subnet.hostmask}")
    print(f"First IP: {subnet.network_address}")
    print(f"First IP (Decimal): {int(subnet.network_address)}")
    print(f"Last IP: {subnet.broadcast_address}")
    print(f"Last IP (Decimal): {int(subnet.broadcast_address)}")
    print(f"Total Hosts: {subnet.num_addresses} with {subnet.num_addresses - 2} Usable")

# Check if a subnet argument is provided
if len(sys.argv) > 1:
    subnet_arg = sys.argv[1]
else:
    # If not provided, prompt the user for the subnet
    subnet_arg = input("Enter a CIDR subnet (e.g., 172.28.1.0/24): ")

# Calculate and report the information
calculate_subnet_info(subnet_arg)

