#!/bin/bash
#Version 1.0.0
#Time 2014年11月18日18:12:44
#FileName nginxsite.sh

#解析域名和绑定域名
DomainName=$1
WebRootDir=/a/domains/${DomainName}/public_html

NginxRootDir=/a/apps/nginx
NginxVhostsDir=${NginxRootDir}/vhosts
NginxIncludeDir=${NginxRootDir}/include
NginxLogsDir=${NginxRootDir}/logs

if [ ! -f ${WebRootDir} ]
    then
        mkdir -p ${WebRootDir}
        echo "mkdir directory :"${WebRootDir}
fi
#写入配置文件
cat > ${NginxVhostsDir}/${DomainName}.conf <<EOF
server {
	listen  80;
	server_name ${DomainName};
	root    ${WebRootDir};
	index index.html index.htm index.shtml index.php;

	error_page  404               /404.html;

	location = /500.html {
	   root   /usr/share/nginx/html;
	}

	location ~ \.php$ {
	    fastcgi_pass   unix:/dev/shm/php.sock;
	    include        fastcgi_params;
	    fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
		access_log  ${NginxLogsDir}/${DomainName}.access.log main;
	}

    location ~ /\.ht {
       deny  all;
    }

	include ${NginxIncludeDir}/static.conf;
}

EOF
echo ${DomainName}" vhost create success , website directory :" ${WebRootDir}
service nginx reload
