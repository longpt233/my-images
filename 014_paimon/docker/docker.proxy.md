

https://stackoverflow.com/questions/73707386/docker-container-refuses-to-not-use-proxy-for-docker-network

global config

```sh
#!/bin/bash

#Proxy
ActiveProxyVar=127.0.0.7

#Domain
corpdom=domain.org

#NoProxy
NOT_PROXY=127.0.0.0/8,172.16.0.0/12,192.168.0.0/16,10.0.0.0/8,.$corpdom

httpproxyvar=http://$ActiveProxyVar/
httpsproxyvar=http://$ActiveProxyVar/

mkdir ~/.docker
cat << EOL >~/.docker/config.json
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "$httpproxyvar",
     "httpsProxy": "$httpsproxyvar",
     "noProxy": "$NOT_PROXY"
   }
 }
}
EOL

mkdir -p /etc/systemd/system/docker.service.d

cat << EOL >/etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$httpproxyvar"
Environment="HTTPS_PROXY=$httpsproxyvar"
Environment="NO_PROXY=$NOT_PROXY"
Environment="http_proxy=$httpproxyvar"
Environment="https_proy=$httpsproxyvar"
Environment="no_proxy=$NOT_PROXY"
EOL

systemctl daemon-reload
systemctl restart docker
#systemctl show --property Environment docker

#docker run hello-world
```


docker-compose.yaml:

```
environment:
  - 'NO_PROXY=${NO_PROXY}'
  - 'no_proxy=${NO_PROXY}'
```

.env 

```
NO_PROXY=127.0.0.0/8,172.16.0.0/12,192.168.0.0/16,10.0.0.0/8,.icinga_icinga-net,icinga2-api,icinga2-web,icinga2-db,icinga2-webdb,icinga2-redis,icinga2-directordb,icinga2-icingadb,icinga2-web_director
```