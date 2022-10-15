#!/usr/bin/env bash

if [ ! -f /etc/haproxy/haproxy.cfg ]; then

  # Install haproxy
  /usr/bin/apt-get -y install haproxy

  # Configure haproxy
  cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD
  cat > /etc/haproxy/haproxy.cfg <<EOD
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

    # Default SSL material locations
    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

    # Default ciphers to use on SSL-enabled listening sockets.
    # For more information, see ciphers(1SSL). This list is from:
    #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
    # An alternative list with additional directives can be obtained from
    #  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
    ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
    ssl-default-bind-options no-sslv3

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http
        
frontend k8s
    mode tcp
    bind192.168.56.111:6443
    option tcplog
    default_backend k8s-masters

backend k8s-masters
    mode tcp
    balance roundrobin
    option tcp-check
    server master01 192.168.56.101:6443 check fall 3 rise 2
    server master02 192.168.56.102:6443 check fall 3 rise 2
    server master03 192.168.56.103:6443 check fall 3 rise 2
    # server worker01 192.168.56.53:6443 check fall 3 rise 2
    # server worker02 192.168.57.54:6443 check fall 3 rise 2
    # server worker03 192.168.56.55:6443 check fall 3 rise 2

listen stats
  bind *:6443
  stats enable
  stats uri /monitor    
EOD

  cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig
  /usr/sbin/service haproxy restart
fi

echo -e "192.168.56.101	master01\n192.168.56.102 master02\n192.168.56.103 master03\n192.168.56.104 worker01\n192.168.56.105	worker02\n192.168.56.106 worker03\n192.168.56.111 loadbalancer" >> /etc/hosts

sudo apt update && sudo apt upgrade -y


