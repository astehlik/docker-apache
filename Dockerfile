FROM ubuntu:24.04

ENV LANG=C.UTF-8

# hadolint ignore=DL3008
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends apache2 \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/docker-httpd-entrypoint
RUN chmod +x /usr/local/bin/docker-httpd-entrypoint

# Create symlinks to write error and access log to stdout / stderr
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
	ln -sf /proc/self/fd/2 /var/log/apache2/error.log

RUN mkdir -p /var/run/apache2
RUN mkdir -p /var/lock/apache2 && chown www-data:www-data /var/lock/apache2

EXPOSE 80
EXPOSE 443

ENV APACHE_CONFDIR=/etc/apache2

ENTRYPOINT ["/usr/local/bin/docker-httpd-entrypoint"]

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]
