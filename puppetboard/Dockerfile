#https://github.com/voxpupuli/puppetboard/blob/master/Dockerfile

FROM python:2.7-alpine

ENV PUPPETBOARD_PORT 80
EXPOSE 80

RUN apk --update add git wget

ENV PUPPETBOARD_SETTINGS docker_settings.py

RUN wget https://github.com/voxpupuli/puppetboard/archive/v0.0.5.tar.gz
RUN tar -zxvf v0.0.5.tar.gz


RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY requirements*.txt /usr/src/app/
RUN pip install -r requirements-docker.txt

COPY . /usr/src/app

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout puppetboard.app:app
