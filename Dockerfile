FROM alpine:latest
MAINTAINER mara https://github.com/ma-ra

RUN apk add --update openvpn openvpn-doc iptables openssl tzdata && \
    cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
    echo "Europe/Warsaw" >  /etc/timezone && \
    cp /usr/share/doc/openvpn/samples/sample-config-files/server.conf /etc/openvpn/server-sample.conf && \
    openssl dhparam -out /etc/openvpn/dh2048.pem 2048 && \
    apk del openvpn-doc tzdata openssl && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*


ADD entrypoint.sh /usr/local/bin/
ADD config.tar.gz /etc/openvpn/    



# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
