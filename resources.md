# DFIR Resource Repository

*A comprehensive collection of Digital Forensics and Incident Response resources*

## Table of Contents

- [Introduction](#introduction)
- [Incident Response Tools](#incident-response-tools)
- [Digital Forensics Suites](#digital-forensics-suites)
- [Memory Analysis](#memory-analysis)
- [Network Forensics](#network-forensics)
- [Malware Analysis](#malware-analysis)
- [OSINT Resources](#osint-resources)
- [Threat Intelligence](#threat-intelligence)
- [Documentation Templates](#documentation-templates)
- [Training Resources](#training-resources)
- [Communities and Forums](#communities-and-forums)
- [Reference Materials](#reference-materials)
- [Cheat Sheets](#cheat-sheets)

## Introduction

This repository contains a curated list of resources for Digital Forensics and Incident Response (DFIR) professionals. These tools, websites, and references are designed to assist in various aspects of cybersecurity investigations and incident handling.

## Incident Response Tools

| Tool | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|------|-----|-------------|------|------------|---------|------------------|-------|
| TheHive | [https://thehive-project.org/](https://thehive-project.org/) | Open-source security incident response platform designed to make life easier for SOCs, CSIRTs, and CERTs | Free | Intermediate | Open Source | Linux, Docker | Integrates with MISP and Cortex |
| MISP | [https://www.misp-project.org/](https://www.misp-project.org/) | Open-source threat intelligence platform for sharing, storing, and correlating IOCs | Free | Intermediate | Open Source | Linux, Docker | Standard for many CERTs and SOCs |
| Velociraptor | [https://docs.velociraptor.app/](https://docs.velociraptor.app/) | Advanced digital forensics and incident response tool that enables you to collect data at scale | Free | Advanced | Open Source | Windows, Linux, macOS | Powerful VQL querying language |
| GRR Rapid Response | [https://github.com/google/grr](https://github.com/google/grr) | Incident response framework focused on remote live forensics | Free | Advanced | Open Source | Windows, Linux, macOS (clients), Linux (server) | Created by Google |

## Digital Forensics Suites

| Tool | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|------|-----|-------------|------|------------|---------|------------------|-------|
| Autopsy | [https://www.autopsy.com/](https://www.autopsy.com/) | Open-source digital forensics platform for disk imaging and analysis | Free | Intermediate | Open Source | Windows, Linux | GUI for The Sleuth Kit |
| SANS SIFT Workstation | [https://www.sans.org/tools/sift-workstation/](https://www.sans.org/tools/sift-workstation/) | Linux distribution with pre-installed forensics tools | Free | Advanced | Open Source | Linux | Created by SANS |
| Kali Linux | [https://www.kali.org/](https://www.kali.org/) | Security-focused Linux distribution with many forensic tools | Free | Intermediate | Open Source | Linux | Maintained by Offensive Security |
| FTK Imager | [https://www.exterro.com/ftk-imager](https://www.exterro.com/ftk-imager) | Forensic imaging tool for creating disk images | Free/Paid | Beginner | Commercial | Windows | Free version available |

## Memory Analysis

| Tool | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|------|-----|-------------|------|------------|---------|------------------|-------|
| Volatility | [https://www.volatilityfoundation.org/](https://www.volatilityfoundation.org/) | Advanced memory forensics framework | Free | Advanced | Open Source | Windows, Linux, macOS | Open-source |
| Rekall | [https://github.com/google/rekall](https://github.com/google/rekall) | Memory forensic framework developed as a fork of Volatility | Free | Advanced | Open Source | Windows, Linux, macOS | Created by Google |
| Redline | [https://www.fireeye.com/services/freeware/redline.html](https://www.fireeye.com/services/freeware/redline.html) | Free tool for memory and file analysis by FireEye | Free | Intermediate | Commercial | Windows | User-friendly interface |
| DumpIt | [https://www.comae.com/](https://www.comae.com/) | Memory acquisition tool | Free/Paid | Beginner | Commercial | Windows | Simple command-line interface |

## Network Forensics

| Tool | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|------|-----|-------------|------|------------|---------|------------------|-------|
| Wireshark | [https://www.wireshark.org/](https://www.wireshark.org/) | The world's foremost network protocol analyzer | Free | Intermediate | Open Source | Windows, Linux, macOS | Open-source |
| NetworkMiner | [https://www.netresec.com/?page=NetworkMiner](https://www.netresec.com/?page=NetworkMiner) | Network forensic analysis tool | Free/Paid | Intermediate | Commercial | Windows | Free and commercial versions |
| Zeek (formerly Bro) | [https://zeek.org/](https://zeek.org/) | Network security monitoring tool | Free | Advanced | Open Source | Linux, macOS | Highly customizable |
| Tshark | [https://www.wireshark.org/docs/man-pages/tshark.html](https://www.wireshark.org/docs/man-pages/tshark.html) | Command-line version of Wireshark | Free | Advanced | Open Source | Windows, Linux, macOS | Great for automation |
| AbuseIPDB | [https://www.abuseipdb.com/](https://www.abuseipdb.com/) | Abused IP Lookup | Free/Paid | Beginner | Commercial | Web-based | Free for basic use|

## Malware Analysis

| Tool | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|------|-----|-------------|------|------------|---------|------------------|-------|
| Ghidra | [https://ghidra-sre.org/](https://ghidra-sre.org/) | Software reverse engineering framework | Free | Advanced | Open Source | Windows, Linux, macOS | Developed by NSA |
| Cuckoo Sandbox | [https://cuckoosandbox.org/](https://cuckoosandbox.org/) | Automated malware analysis system | Free | Advanced | Open Source | Linux (host), multiple (guests) | Open-source |
| VirusTotal | [https://www.virustotal.com/](https://www.virustotal.com/) | Online service that analyzes files and URLs for malware | Free/Paid | Beginner | Commercial | Web-based | Free for basic use |
| IDA Pro | [https://hex-rays.com/ida-pro/](https://hex-rays.com/ida-pro/) | Disassembler and debugger for software analysis | Paid | Advanced | Commercial | Windows, Linux, macOS | Industry standard |

## OSINT Resources

| Resource | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|----------|-----|-------------|------|------------|---------|------------------|-------|
| Shodan | [https://www.shodan.io/](https://www.shodan.io/) | Search engine for internet-connected devices | Free/Paid | Intermediate | Commercial | Web-based | The "search engine for hackers" |
| OSINT Framework | [https://osintframework.com/](https://osintframework.com/) | Collection of OSINT tools | Free | Beginner | Open Source | Web-based | Organized by category |
| Maltego | [https://www.maltego.com/](https://www.maltego.com/) | Open-source intelligence and graphical link analysis tool | Free/Paid | Intermediate | Commercial | Windows, Linux, macOS | Free community edition |
| Hunter.io | [https://hunter.io/](https://hunter.io/) | Email finder and verifier | Free/Paid | Beginner | Commercial | Web-based | Useful for organizational reconnaissance |

## Threat Intelligence

| Resource | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|----------|-----|-------------|------|------------|---------|------------------|-------|
| AlienVault OTX | [https://otx.alienvault.com/](https://otx.alienvault.com/) | Open Threat Exchange with community-contributed IOCs | Free | Beginner | Commercial | Web-based | Free |
| MITRE ATT&CK | [https://attack.mitre.org/](https://attack.mitre.org/) | Knowledge base of adversary tactics and techniques | Free | Intermediate | Open Source | Web-based | Industry standard framework |
| VirusTotal Intelligence | [https://www.virustotal.com/gui/intelligence-overview](https://www.virustotal.com/gui/intelligence-overview) | Advanced searching and monitoring of malware | Paid | Advanced | Commercial | Web-based | Subscription-based |
| ThreatConnect | [https://threatconnect.com/](https://threatconnect.com/) | Threat intelligence platform | Paid | Advanced | Commercial | Web-based | Commercial product |

## Documentation Templates

| Template | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|----------|-----|-------------|------|------------|---------|------------------|-------|
| SANS Incident Response Forms | [https://www.sans.org/score/incident-forms/](https://www.sans.org/score/incident-forms/) | Collection of forms for IR documentation | Free | Beginner | Open Source | Platform-independent | Industry standard |
| NIST SP 800-61 Templates | [https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final](https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final) | Templates based on NIST's Incident Handling Guide | Free | Intermediate | Open Source | Platform-independent | Government standard |
| Chain of Custody Form | [Example - Replace with your template location] | Documentation for maintaining evidence integrity | Free | Beginner | Open Source | Platform-independent | Critical for legal proceedings |
| Investigation Report | [Example - Replace with your template location] | Template for final investigation reports | Free | Intermediate | Open Source | Platform-independent | Customize for your organization |

## Training Resources

| Resource | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|----------|-----|-------------|------|------------|---------|------------------|-------|
| SANS Courses | [https://www.sans.org/](https://www.sans.org/) | Professional training in digital forensics and IR | Paid | Beginner to Advanced | Commercial | Web-based/In-person | Industry leading |
| DFIR Diva | [https://dfirdiva.com/](https://dfirdiva.com/) | Extensive list of training resources | Free | Beginner to Advanced | Open Source | Web-based | Regularly updated |
| Cybrary | [https://www.cybrary.it/](https://www.cybrary.it/) | Free and paid online cybersecurity courses | Free/Paid | Beginner to Intermediate | Commercial | Web-based | Good for beginners |
| Pluralsight | [https://www.pluralsight.com/](https://www.pluralsight.com/) | Online training platform with many security courses | Paid | Beginner to Advanced | Commercial | Web-based | Subscription-based |

## Communities and Forums

| Community | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|-----------|-----|-------------|------|------------|---------|------------------|-------|
| SANS DFIR | [https://www.sans.org/community/](https://www.sans.org/community/) | DFIR community forums and resources | Free | Beginner to Advanced | Commercial | Web-based | Active community |
| Reddit DFIR | [https://www.reddit.com/r/computerforensics/](https://www.reddit.com/r/computerforensics/) | Subreddit for digital forensics discussions | Free | Beginner to Advanced | Open Source | Web-based | Good for questions |
| DFIR Discord | [Example - Replace with relevant Discord] | Real-time chat for DFIR professionals | Free | Beginner to Advanced | Commercial | Web-based/App | Networking opportunity |
| ForensicFocus | [https://www.forensicfocus.com/](https://www.forensicfocus.com/) | Online forum dedicated to digital forensics | Free | Beginner to Advanced | Commercial | Web-based | Long-established community |

## Reference Materials

| Reference | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|-----------|-----|-------------|------|------------|---------|------------------|-------|
| SANS Reading Room | [https://www.sans.org/reading-room/](https://www.sans.org/reading-room/) | Free research papers on security topics | Free | Intermediate to Advanced | Commercial | Web-based | Extensive library |
| Digital Forensics Magazine | [https://digitalforensicsmagazine.com/](https://digitalforensicsmagazine.com/) | Industry publication for DFIR professionals | Paid | Intermediate | Commercial | Web-based/Print | Subscription-based |
| NIST Special Publications | [https://csrc.nist.gov/publications/sp](https://csrc.nist.gov/publications/sp) | Government standards and guidelines | Free | Advanced | Open Source | Web-based | Authoritative source |
| DFIR Review | [https://dfir.pubpub.org/](https://dfir.pubpub.org/) | Peer-reviewed platform for sharing DFIR research | Free | Advanced | Open Source | Web-based | High-quality content |

## Cheat Sheets

| Cheat Sheet | URL | Description | Cost | Complexity | License | OS Compatibility | Notes |
|-------------|-----|-------------|------|------------|---------|------------------|-------|
| SANS DFIR Cheat Sheets | [https://digital-forensics.sans.org/community/cheat-sheets](https://digital-forensics.sans.org/community/cheat-sheets) | Collection of reference sheets for tools and techniques | Free | Beginner to Advanced | Commercial | Platform-independent | Printable PDFs |
| Volatility Cheat Sheet | [Example - Replace with preferred resource] | Quick reference for Volatility commands | Free | Intermediate | Open Source | Platform-independent | Tool-specific |
| Linux Forensics Cheat Sheet | [Example - Replace with preferred resource] | Common Linux forensic commands | Free | Intermediate | Open Source | Linux | OS-specific |
| Windows Forensics Cheat Sheet | [Example - Replace with preferred resource] | Windows artifact locations and analysis tips | Free | Intermediate | Open Source | Windows | OS-specific |

---

*Last Updated: 4/30/2025*

---
