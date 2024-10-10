# Start from the Kali Linux rolling image
FROM kalilinux/kali-rolling

# Update the package list and install nmap, hydra, and wget
RUN apt-get update && apt-get install -y \
    nmap \
    hydra \
    wget \
    && rm -rf /var/lib/apt/lists/*  # Clean up

RUN mkdir -p /usr/share/wordlists

# Copy the rockyou.txt file from the host to the Docker image
COPY rockyou.txt /usr/share/wordlists/rockyou.txt

# Set the default command to run when starting the container
CMD ["/bin/bash"]

