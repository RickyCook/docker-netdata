FROM lsiobase/alpine:3.5

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install runtime packages
RUN \
 apk add --no-cache python3 \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	netdata && \

 pip3 install pyyaml \

# cleanup
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
EXPOSE 19999
VOLUME /config
