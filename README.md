# 🎖 Spouse Hack Challenge

This repository sets up a small "gamified" challenge to teach your spouse about the basics computer security and attacks. It's a fun little date idea ♥

## Scenario Overview

Leveraging an attacker machine (Kali Linux Docker Container) and a "vulnerable" server (Ubuntu 22.04 Docker Container), the goal of the challenge is to get to the `/root/deeboodah.txt` to read a message.

Using attacker machine, your spouse will have to:

1) Enumerate the challenge server for open ports. 
2) Attempt to password crack into port 22. (password is `admin`). 
3) Read three files (`readme.txt`) in the `/home/user` directory. Each file has a small riddle and clue into what command to issue next.
4) Once all three files have been read, a new user account should be provisioned in the `/etc/passwd` file, which will provide privilege escalation (reset the password of the new account with `passwd hacker`). The script `check-etc-passwd.etc` will echo this command to the console.
5) Navigate into root's directory to read the message!

The two docker containers install the necessary dependencies to set up this scenario.

- The Kali Linux docker container install nmap for port enumeration and hydra for password cracking.
    - Note: If you want a password list to use, download [rockyou.txt](https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt) and place it in the `kali` folder. (I could not upload this as its too big.)
- The Ubuntu server installs openssh. 

## Download

Change directories into where you want to download this repo.

Issue: `git clone https://github.com/collinsmc23/spouse-hack-challenge.git`

Build two docker images. 

1) Kali Linux: `docker build -t {docker-image-name} -f /kali/Dockerfile .`
2) Ubuntu Server: `docker build -t {docker-image-name} Dockerfile`

Run the Docker containers:

1) Kali Linux: `docker run -it {docker-image-name}`.
2) Ubuntu: `docker run -d -p 2222:22 --name {docker-image-name} ubuntu_22.04`
