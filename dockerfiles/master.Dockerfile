FROM ansible-img

# Install dependencies
RUN apt update && apt install -y vim python net-tools telnet curl

# Copy masters's private key
RUN mkdir /root/.ssh
COPY ssh_keys/ansible /root/.ssh/ansible
RUN chmod 0600 /root/.ssh/ansible
