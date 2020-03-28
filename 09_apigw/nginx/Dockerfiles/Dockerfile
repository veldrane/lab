FROM registry.lab.local/base/centos:7.7.1908
LABEL maintainer="-veldrane"
ENV NGINX_VERSION 1.16.1
COPY start.sh /

RUN GPG_KEYS=B0F4253373F8F6F510D42178520A9993A1C052F8 \
  && curl http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz \
	&& CONFIG="\
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
		--user=nginx \
		--group=nginx \
		--with-http_ssl_module \
		--with-http_realip_module \
		--with-http_addition_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_random_index_module \
		--with-http_secure_link_module \
		--with-http_stub_status_module \
		--with-http_auth_request_module \
		--with-http_xslt_module=dynamic \
		--with-http_image_filter_module=dynamic \
		--with-http_geoip_module=dynamic \
		--with-threads \
		--with-stream \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-stream_realip_module \
		--with-stream_geoip_module=dynamic \
		--with-http_slice_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-compat \
		--with-file-aio \
		--with-http_v2_module \
	" \
	&& groupadd -g 998 -r nginx \
	&& adduser -u 999 -m -r -d /var/cache/nginx -s /sbin/nologin -g nginx nginx \
        && yum-config-manager --enable rhel-7-server-optional-rpms \
	&& yum install -y \
		gcc \
		glibc-devel \
		make \
		openssl-devel \
		pcre-devel \
		zlib-devel \
		kernel-headers \
		curl \
		gnupg2 \
		libxslt-devel \
		gd-devel \
		GeoIP-devel \
                lua \
                lua-cjson
	&& mkdir -p /usr/src \
	&& tar -zxC /usr/src -f nginx.tar.gz \
	&& rm nginx.tar.gz \
	&& cd /usr/src/nginx-$NGINX_VERSION \
	&& ./configure $CONFIG --with-debug \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& mv objs/nginx objs/nginx-debug \
	&& mv objs/ngx_http_xslt_filter_module.so objs/ngx_http_xslt_filter_module-debug.so \
	&& mv objs/ngx_http_image_filter_module.so objs/ngx_http_image_filter_module-debug.so \
	&& mv objs/ngx_http_geoip_module.so objs/ngx_http_geoip_module-debug.so \
	&& mv objs/ngx_stream_geoip_module.so objs/ngx_stream_geoip_module-debug.so \
	&& ./configure $CONFIG \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& make install \
	&& rm -rf /etc/nginx/html/ \
	&& mkdir /etc/nginx/conf.d \
	&& mkdir -p /usr/share/nginx/html/ \
	&& install -m644 html/index.html /usr/share/nginx/html/ \
	&& install -m644 html/50x.html /usr/share/nginx/html/ \
	&& install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
	&& install -m755 objs/ngx_http_xslt_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_xslt_filter_module-debug.so \
	&& install -m755 objs/ngx_http_image_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_image_filter_module-debug.so \
	&& install -m755 objs/ngx_http_geoip_module-debug.so /usr/lib/nginx/modules/ngx_http_geoip_module-debug.so \
	&& install -m755 objs/ngx_stream_geoip_module-debug.so /usr/lib/nginx/modules/ngx_stream_geoip_module-debug.so \
	&& ln -s ../../usr/lib/nginx/modules /etc/nginx/modules \
	&& strip /usr/sbin/nginx* \
	&& strip /usr/lib/nginx/modules/*.so \
	&& rm -rf /usr/src/nginx-$NGINX_VERSION \
        \
	# Bring in gettext so we can get `envsubst`, then throw
	# the rest away. To do this, we need to install `gettext`
	# then move `envsubst` out of the way so `gettext` can
	# be deleted completely, then move `envsubst` back.
	&& yum install gettext \
	&& mv /usr/bin/envsubst /tmp/ \
	&& mv /tmp/envsubst /usr/local/bin/ \
	\
	# Bring in tzdata so users could set the timezones through the environment
	# variables
	&& yum install -y tzdata \
	\
	# forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
        && rpm -e --nodeps \
                gcc \
                glibc-devel \
                make \
                openssl-devel \
                pcre-devel \
                zlib-devel \
                kernel-headers \
                gnupg2 \
                libxslt-devel \
                gd-devel \
                GeoIP-devel \
	&& yum clean all \
        && ln -sf /proc/1/fd/1 /var/log/nginx/access.log \
        && ln -sf /proc/1/fd/1 /var/log/nginx/stream-access.log \
        && ln -sf /proc/1/fd/2 /var/log/nginx/error.log \
        && mkdir -p /etc/nginx/secrets \
        && mkdir -p /etc/nginx/templates \
        && chown nginx.root /etc/nginx \
        && chmod 770 /etc/nginx \
        && chmod 770 /etc/nginx/secrets \
        && chmod 770 /etc/nginx/templates \
        && chmod 770 /etc/nginx/conf.d \
        && mkdir -p /var/lib/nginx \
        && chown nginx.root /var/lib/nginx \
        && chmod 770 /var/lib/nginx \
        && chmod 660 /etc/nginx/nginx.conf \
        && chown -R nginx.root /var/cache/nginx \
        && chmod 770 /var/cache/nginx \
        && chmod 770 /run \
        && chmod +x /start.sh \
        && sed -i 's/listen 443/listen 8443/g' /etc/nginx/nginx.conf \
        && sed -i 's/listen 80/listen 8080/g' /etc/nginx/nginx.conf 
      
ENTRYPOINT ["/start.sh"]

