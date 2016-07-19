#!/bin/bash
#Version 1.0.0
#Time 2014年11月18日18:12:44
#FileName nginxsite.sh

if [ $# -lt 2 ]
then
    echo "need param: sub-domain and port;"
    exit;
fi

#解析域名和绑定域名
MainDomain=xiamingxing.com
SubDomain=$1
ProxyPort=$2
DomainName=${SubDomain}.${MainDomain}
WebRootDir=/a/domains/${DomainName}/public_html

NginxRootDir=/a/apps/nginx
NginxVhostsDir=${NginxRootDir}/vhosts
NginxIncludeDir=${NginxRootDir}/include
NginxLogsDir=${NginxRootDir}/logs

#写入配置文件
cat > ${NginxVhostsDir}/${DomainName}.conf <<EOF
upstream ${SubDomain} {
    server 127.0.0.1:${ProxyPort};
    keepalive 64;
}

server {
    listen 80;
    server_name ${DomainName};
    location / {
        include ${NginxIncludeDir}/proxy_set_header.conf;
        proxy_pass http://${SubDomain};
        access_log  ${NginxLogsDir}/${DomainName}.access.log main;
        proxy_cache_purge \$purge_method;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|woff|woff2|svg|ico)$
    {
        etag	on;
        expires 30d;
        access_log off;
        log_not_found     off;
        include ${NginxIncludeDir}/proxy_set_header.conf;
        proxy_pass http://${SubDomain};
    }

    location ~ .*\.(js|css)?$
    {
        etag	on;
        expires 12h;
        access_log off;
        log_not_found     off;
        include ${NginxIncludeDir}/proxy_set_header.conf;
        proxy_pass http://${SubDomain};
    }
}

EOF
echo ${DomainName}" vhost create success , proxy port :" ${ProxyPort}
service nginx reload
