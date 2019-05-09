FROM ubuntu:18.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \

	&& apt-get install -y apache2 \

	&& apt-get --purge autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
