FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y openssh-server sudo tini

RUN mkdir /var/run/sshd

RUN useradd -m -s /bin/bash user && echo 'user:admin' | chpasswd && usermod -aG sudo user

RUN echo "root:@Changeme101" | chpasswd

# Copy 'deeboodah.txt' to root's home directory
COPY deeboodah.txt /root/

# Copy 'readme.txt', 'readme2.txt', and 'readme3.txt' to user's home directory
COPY readme.txt /home/user/
COPY readme2.txt /home/user/
COPY readme3.txt /home/user/.readme3.txt

# Set ownership and permissions
RUN chown user:user /home/user/readme.txt /home/user/readme2.txt /home/user/.readme3.txt
RUN chmod 000 /home/user/readme2.txt

# Change permissions on /etc/passwd
RUN chmod 777 /etc/passwd

# Create the /home/scripts directory and copy the check-etc-passwd.sh script into it
RUN mkdir -p /home/scripts
COPY check-etc-passwd.sh /home/scripts/check-etc-passwd.sh

# Make the script executable
RUN chmod +x /home/scripts/check-etc-passwd.sh
RUN /home/scripts/check-etc-passwd.sh &


# Allow password authentication (optional: more secure keys-based auth can be added)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose port 22 for SSH
EXPOSE 22

# Start the SSH service
#CMD ["/usr/sbin/sshd", "-D"]
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & /home/scripts/check-etc-passwd.sh & wait"]

