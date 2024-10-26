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

