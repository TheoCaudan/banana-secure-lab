FROM debian:12

RUN apt-get update && apt-get install -y --no-install-recommends \
    nftables net-tools iputils-ping iproute2 openssh-server tcpdump traceroute netcat-openbsd isc-dhcp-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd && \
    echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf && \
    ssh-keygen -A

EXPOSE 22

CMD ["sleep", "infinity"]