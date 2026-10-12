FROM docker.io/library/caddy:2.11.4-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY site/ /srv/

EXPOSE 8080
