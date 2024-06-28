FROM ubuntu:16.04

# Install dependencies
RUN apt-get update && apt-get install -y openssh-server vim python3 net-tools telnet
RUN mkdir /var/run/sshd

# root login
RUN echo 'root:ansible' | chpasswd

# Authorize root login over ssh
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# copy master public key
RUN mkdir /root/.ssh/
COPY ssh_keys/ansible.pub /root/.ssh/ansible.pub
RUN cp -v /root/.ssh/ansible.pub /root/.ssh/authorized_keys

# ?
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Open ssh port
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
