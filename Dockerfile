ARG ARCH=
FROM ${ARCH}debian:bullseye-slim

RUN apt-get update \
&& apt-get install --no-install-recommends -y nut-cgi fcgiwrap nginx-light \
&& rm -rf /var/lib/apt/lists/*

COPY start.sh /
RUN chmod +x /start.sh

COPY nginx-default /etc/nginx/sites-available/default

RUN mv /etc/nut/hosts.conf /etc/nut/hosts.conf.original && \
    mv /etc/nut/upsstats.html /etc/nut/upsstats.html.sample && \
    mv /etc/nut/upsstats-single.html /etc/nut/upsstats-single.html.sample

COPY template/* /etc/nut/


ENTRYPOINT [ "/start.sh" ]

EXPOSE 80
