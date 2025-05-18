FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    apt-transport-https \
    ca-certificates

RUN curl -fsSL https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc \
    | gpg --dearmor -o /usr/share/keyrings/tor-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bullseye main" \
    > /etc/apt/sources.list.d/tor.list

RUN apt-get update && apt-get install -y \
    tor \
    privoxy \
    nyx \
    deb.torproject.org-keyring && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./bin/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9001 9030 8118

CMD ["/start.sh"]
