FROM debian:12

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server nftables net-tools iputils-ping mariadb-client iproute2 netcat-openbsd curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd /etc/test && \
    ssh-keygen -A

COPY test.sh /etc/test/test.sh
RUN chmod +x /etc/test/test.sh

EXPOSE 22

CMD ["/init.sh"]