#!/bin/bash

# Check if the input file was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 domain_list.txt"
    exit 1
fi

# Ensure necessary commands are available
for cmd in shodan httpx; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed." >&2
        exit 1
    fi
done

# Check if EyeWitness is installed
if [ ! -d "/usr/share/eyewitness" ]; then
    echo "Error: EyeWitness is not installed. Install it on Kali via: sudo apt-get install eyewitness" >&2
    exit 1
fi

# Read the domain list file
DOMAIN_FILE="$1"

# Directory to store all outputs
mkdir -p outputs/eyewitness

# Function to process each domain
process_domain() {
    TARGET_DOMAIN=$1
    # Extract information from Shodan
    shodan search "ssl.cert.subject.CN:$TARGET_DOMAIN" --fields ip_str,hostnames > "outputs/${TARGET_DOMAIN}_shodan_results.txt"

    # Use httpx to check technologies installed and save to a file
    cat "outputs/${TARGET_DOMAIN}_shodan_results.txt" | awk '{print $1}' | httpx -title -tech-detect -status-code -o "outputs/${TARGET_DOMAIN}_httpx_results.txt"

    # Extract live domain IPs and save to a separate file
    awk '{print $1}' "outputs/${TARGET_DOMAIN}_shodan_results.txt" > "outputs/${TARGET_DOMAIN}_live_ips.txt"

    # Take screenshots of the domains using EyeWitness
    cat "outputs/${TARGET_DOMAIN}_shodan_results.txt" | awk '{print $1}' > "outputs/${TARGET_DOMAIN}_urls.txt"
    eyewitness --web -f "outputs/${TARGET_DOMAIN}_urls.txt" --no-prompt -d "outputs/eyewitness/${TARGET_DOMAIN}"
}

# Export the function for parallel to use
export -f process_domain

# Use parallel to execute the function for each line in the file
cat "$DOMAIN_FILE" | parallel process_domain

echo "All tasks completed."
