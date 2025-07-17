FROM debian:12

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    wget curl gnupg2 gnupg lsb-release apt-transport-https ca-certificates sudo \
    php-fpm nginx git traceroute unzip iputils-ping netcat-traditional openssh-server nftables && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt-get update && apt-get upgrade -y && apt-get install -y php8.3-fpm php8.3-mysql

RUN groupadd bananacorp && useradd -m -s /bin/bash -g bananacorp bananawp

COPY php-fpm.conf /etc/php/8.3/fpm/pool.d/bananawp.conf

COPY nginx.conf /etc/nginx/sites-available/default

RUN mkdir /var/run/sshd

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C /var/www/html && \
    chown -R bananawp:bananacorp /var/www/html/wordpress
    
COPY wp-config.php /var/www/html/wordpress/wp-config.php

EXPOSE 80 22 39100

CMD ["sleep", "infinity"]