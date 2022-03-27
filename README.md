# nut-cgi

Multi arch docker image hosting nut-cgi with bootstrap based theme supporting darkmode.

## Run
```
docker run -d \
    --name nut-cgi \
    -p 6543:80 \
    -e NUT_HOSTS='MONITOR ups@server "UPS Name"' \
    64bitint/nut-cgi
```
