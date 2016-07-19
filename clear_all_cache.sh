#!/bin/bash
#Version 1.0.0
#Time 2014年11月18日18:12:44

NginxDir=/a/apps/nginx;
CacheDir=${NginxDir}/cache;

ProxyTempDir=${CacheDir}/proxy_temp;
ProxyTempFile=${ProxyTempDir}/*;
ProxyCacheDir=${CacheDir}/proxy_cache;
ProxyCacheFile=${ProxyCacheDir}/*;

echo "-------------------------------------------------------------------------------------------------------------";

echo "proxy cache files:"
du -sh ${ProxyTempFile}  
du -sh ${ProxyCacheFile}

rm -rf ${ProxyTempFile}
rm -rf ${ProxyCacheFile}

echo "clear all proxy cache and temp files;";

echo "-------------------------------------------------------------------------------------------------------------";

FastcgiTempDir=${CacheDir}/fastcgi_temp;
FastcgiTempFile=${FastcgiTempDir}/*;
FastcgiCacheDir=${CacheDir}/fastcgi_cache;
FastcgiCacheFile=${FastcgiCacheDir}/*;

echo "fastcgi cache files:"
du -sh ${FastcgiTempFile} 
du -sh ${FastcgiCacheFile}

rm -rf ${FastcgiTempFile}
rm -rf ${FastcgiCacheFile}

echo "clear all fastcgi cache and temp files;"

echo "--------------------------------------------------------------------------------------------------------------";

PageSpeedCache=${CacheDir}/ngx_pagespeed;
PageSpeedFile=${PageSpeedCache}/*;

echo "ngx_pagespeed files:"
du -sh ${PageSpeedFile}

rm -rf ${PageSpeedFile}

echo "clear all ngx_pagespeed files;";
