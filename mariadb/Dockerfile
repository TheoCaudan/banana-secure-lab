FROM mariadb:10.11

RUN apt-get update && apt-get install -y --no-install-recommends \
    nftables net-tools iputils-ping openssh-server curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd && \
    ssh-keygen -A

EXPOSE 22 3306

CMD ["sleep", "infinity"]