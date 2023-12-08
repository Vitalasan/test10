FROM ubuntu:latest
USER root
RUN echo 'root:root' | chpasswd
RUN apt-get update && apt install openssh-server sudo -y
# workdir for ssh
RUN mkdir -p /run/sshd
# generate server keys
RUN ssh-keygen -A
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
EXPOSE 22
# run ssh server
CMD ["/usr/sbin/sshd", "-D"]
