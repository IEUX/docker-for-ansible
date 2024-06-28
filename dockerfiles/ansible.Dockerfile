FROM ubuntu:20.04
ENV ANSIBLE_VERSION 2.9.17

# Install dependencies
RUN apt-get update; \
    apt-get install --fix-missing; \
    apt-get install -y gcc python3; \
    apt-get install -y python3-pip; \
    DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y sshpass openssh-client;

# Install ansible
RUN pip3 install --upgrade pip; \
    pip3 install "ansible==${ANSIBLE_VERSION}"; \
    pip3 install ansible

# Add 'localhost' to the hosts
RUN mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts