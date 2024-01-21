import ipaddress

# Ask the user for a CIDR subnet
user_input = input("Enter a CIDR subnet (e.g., 172.28.1.0/24): ")

# Parse the user input as a CIDR subnet
try:
    subnet = ipaddress.IPv4Network(user_input, strict=False)
except ValueError:
    print("Invalid CIDR subnet format. Please use the format x.x.x.x/xx.")
    exit(1)

# Calculate and report the information
print(f"CIDR Range: {subnet}")
print(f"Netmask: {subnet.netmask}")
print(f"Wildcard Bits: {subnet.hostmask}")
print(f"First IP: {subnet.network_address}")
print(f"First IP (Decimal): {int(subnet.network_address)}")
print(f"Last IP: {subnet.broadcast_address}")
print(f"Last IP (Decimal): {int(subnet.broadcast_address)}")
print(f"Total Hosts: {subnet.num_addresses} with {subnet.num_addresses - 2} Usable")

