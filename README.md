# shodcon
Shodan Recon for BBH

# Automated Reconnaissance Script for Bug Bounty

## Introduction
This tool automates the process of reconnaissance in bug bounty hunting. It is designed to help security researchers and bug bounty hunters gather essential information about multiple target domains quickly and efficiently.

## Features
- **Automated Domain Search**: Utilizes Shodan to search for specific domain-related information.
- **Technology Detection**: Employs `httpx` to detect technologies used on the target domains.
- **IP Extraction**: Extracts live IPs for further testing such as network scanning or fuzzing.
- **Visual Reconnaissance**: Uses EyeWitness to take screenshots of each domain, aiding in visual assessment of potential vulnerabilities.

## Why This Tool?
For bug bounty hunters, time is crucial. This tool reduces the manual overhead of performing initial reconnaissance on target domains, allowing hunters to focus on analyzing potential vulnerabilities more quickly and effectively.

## Prerequisites
- Shodan CLI
- httpx
- EyeWitness (Installed in Kali Linux via `sudo apt-get install eyewitness`)

## Usage
```bash
chmod +x recon_script.sh
./recon_script.sh domain_list.txt
```

## Installation of Dependencies
Ensure you have the required tools:
```
sudo apt update
sudo apt install parallel shodan httpx eyewitness
```

## Contributing
Feel free to fork this repository and contribute by submitting a pull request.


## Acknowledgments
Thanks to all the developers and contributors of Shodan, httpx, and EyeWitness.
