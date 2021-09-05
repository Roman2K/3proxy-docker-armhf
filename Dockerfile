FROM debian:stable-20210902-slim AS debian-updated

RUN apt-get -y update

FROM debian-updated
ARG v=0.9.4

RUN apt-get -y --no-install-recommends install ca-certificates curl

USER nobody
WORKDIR /tmp
RUN curl -LO "https://github.com/3proxy/3proxy/releases/download/$v/3proxy-$v.arm.deb"
RUN mv 3proxy*.deb 3proxy.deb

FROM debian-updated

RUN apt-get -y --no-install-recommends install psmisc

WORKDIR /tmp
COPY --from=1 /tmp/3proxy.deb ./
RUN dpkg -i 3proxy.deb

USER nobody
COPY 3proxy.cfg ./
ENTRYPOINT ["3proxy", "3proxy.cfg"]
