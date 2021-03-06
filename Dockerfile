#
# youtube-dl Server Dockerfile
#
# https://github.com/manbearwiz/youtube-dl-server-dockerfile
#

FROM python:alpine

RUN apk add --no-cache \
  ffmpeg \
  tzdata

RUN mkdir -p /home/app
WORKDIR /home/app

COPY requirements.txt /home/app/
RUN apk --update-cache add --virtual build-dependencies gcc libc-dev make \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del build-dependencies

RUN addgroup appgroup && \
    adduser --disabled-password -G appgroup app
	
USER app

COPY . /home/app

EXPOSE 8080

CMD [ "python", "-u", "./youtube-dl-server.py" ]
