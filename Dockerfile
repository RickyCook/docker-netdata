FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install runtime packages
RUN \
 apk add --no-cache python3 && \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	netdata && \

 pip3 install pyyaml && \

# cleanup
 rm -rf /root/.cache

# install python plugins
RUN \
 apk add --no-cache ca-certificates openssl && \
 wget \
  -O netdata.zip \
  https://github.com/firehol/netdata/archive/v$(netdata -v | awk '{print $2}').zip && \

 unzip netdata.zip && \
 mv netdata-*/python.d /usr/libexec/netdata/ && \

# cleanup
 apk del ca-certificates openssl && \
 rm -rf \
  /root/.cache \
  netdata*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 19999
VOLUME /config
