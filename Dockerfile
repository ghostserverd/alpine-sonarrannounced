FROM lsiobase/alpine.python:3.6
MAINTAINER ghostserverd

RUN echo "force latest 2020-07-06.1"

RUN apk add --no-cache python3 \
 && python3 -m ensurepip \
 && rm -r /usr/lib/python*/ensurepip \
 && pip3 install --upgrade pip setuptools \
 && rm -r /root/.cache

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

# download and install announcedd
RUN mkdir -p /var/log/announcedd \
 && git clone https://github.com/ghostserverd/sonarrAnnounced.git /usr/share/announcedd \
 && pip3 install -r /usr/share/announcedd/requirements.txt

# add local files
COPY root/ /
COPY settings.cfg /

RUN chown -R abc:abc /config /usr/share/announcedd

# ports and volumes
EXPOSE 3467
WORKDIR /config
VOLUME /config /logs
