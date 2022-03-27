ARG ARCH=
FROM ${ARCH}debian:buster-slim

RUN apt-get update \
&& apt-get install --no-install-recommends -y nut-cgi fcgiwrap lighttpd \
&& rm -rf /var/lib/apt/lists/*

COPY start.sh /
RUN chmod +x /start.sh

RUN mv /etc/nut/hosts.conf /etc/nut/hosts.conf.original && \
    mv /etc/nut/upsstats.html /etc/nut/upsstats.html.sample && \
    mv /etc/nut/upsstats-single.html /etc/nut/upsstats-single.html.sample

COPY template/* /etc/nut/

RUN rm -f /etc/lighttpd/conf-enabled/*-unconfigured.conf && \
    ln -s /etc/lighttpd/conf-available/*-accesslog.conf /etc/lighttpd/conf-enabled/ && \
    ln -s /etc/lighttpd/conf-available/*-cgi.conf /etc/lighttpd/conf-enabled/ && \
    sed -i 's|/cgi-bin/|/|g' /etc/lighttpd/conf-enabled/*-cgi.conf && \
    sed -i 's|^\(server.document-root.*=\).*|\1 "/usr/lib/cgi-bin/nut"|g' /etc/lighttpd/lighttpd.conf && \
    sed -i 's|^\(index-file.names.*=\).*|\1 ( "upsstats.cgi" )|g' /etc/lighttpd/lighttpd.conf && \
    sed -i '/alias.url/d' /etc/lighttpd/conf-enabled/*-cgi.conf


ENTRYPOINT [ "/start.sh" ]

EXPOSE 80
