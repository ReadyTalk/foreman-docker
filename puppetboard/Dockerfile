#https://github.com/voxpupuli/puppetboard/blob/master/Dockerfile

FROM python:2.7-alpine

ENV PUPPETBOARD_PORT 80
EXPOSE 80

RUN apk --update add git wget

RUN wget https://github.com/voxpupuli/puppetboard/archive/v0.0.5.tar.gz
RUN tar -zxvf v0.0.5.tar.gz

WORKDIR puppetboard-0.0.5

RUN pip install -r requirements.txt
RUN pip install gunicorn

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout puppetboard.app:app
