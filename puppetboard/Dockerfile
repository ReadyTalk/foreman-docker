#https://github.com/voxpupuli/puppetboard/blob/master/Dockerfile

FROM python:2.7-alpine

EXPOSE 9090

RUN apk --update add git wget

RUN wget https://github.com/voxpupuli/puppetboard/archive/v0.0.5.tar.gz
RUN tar -zxvf v0.0.5.tar.gz

WORKDIR puppetboard-0.0.5

RUN pip install -r requirements.txt
RUN pip install gunicorn supervisor

ADD default_settings.py /var/www/puppetboard/settings.py
ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /var/log/supervisor/puppetboard

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
