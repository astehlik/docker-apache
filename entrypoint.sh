#!/bin/sh

if [ -n "${HTTPD_ENABLE_MODS+x}" ]; then
        for mod in ${HTTPD_ENABLE_MODS}; do
                a2enmod "$mod"
        done
fi

if [ -n "${HTTPD_DISABLE_MODS+x}" ]; then
        for mod in ${HTTPD_DISABLE_MODS}; do
                a2dismod "$mod"
        done
fi

if [ -n "${HTTPD_ENABLE_CONF+x}" ]; then
        for conf in ${HTTPD_ENABLE_CONF}; do
                a2enconf "$conf"
        done
fi

if [ -n "${HTTPD_DISABLE_CONF+x}" ]; then
        for conf in ${HTTPD_DISABLE_CONF}; do
                a2disconf "$conf"
        done
fi

if [ -n "${HTTPD_ENABLE_SITES+x}" ]; then
        for site in ${HTTPD_ENABLE_SITES}; do
                a2ensite "$site"
        done
fi

if [ -n "${HTTPD_DISABLE_SITES+x}" ]; then
        for site in ${HTTPD_DISABLE_SITES}; do
                a2dissite "$site"
        done
fi

# shellcheck source=/dev/null
. /etc/apache2/envvars

exec "$@"
