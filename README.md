# OpenVPN for Docker based on Alpine Linux

## Quick Start
* Go to the folder with file Dockerfile.
* Put tar archive named config.tar.gz with openvpn configuration files, appropriate certificates and keys. 
  You do not need to put a file dh2048.pem, because it is created automatically
* Build:

      docker build -t mara88/docker-alpine-openvpn .
* Run:

      docker run --name=openvpn -h openvpn -d --privileged=true \
        --link squid:squid \
        --link localbind:localbind \
        --link lemp:lemp \
        -p 1194:1194/udp mara88/docker-alpine-openvpn
      
* Show log:

      docker logs openvpn
      
* Run shell into container

      docker exec -it openvpn /bin/sh

* Install as systemd service:

      docker stop openvpn
      cp docker.openvpn.service /etc/systemd/system/
      systemctl enable docker.openvpn
      systemctl start docker.openvpn
