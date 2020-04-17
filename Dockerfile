FROM python:3.8.2-alpine3.11
WORKDIR /app

RUN apk --update add build-base gcc abuild binutils linux-headers libffi-dev libressl-dev \
    bash curl && \
  rm -rf /tmp/* /var/cache/apk/*

COPY requirements.txt /app
COPY .pylintrc /root/
RUN pip install --upgrade pip && pip install -r /app/requirements.txt
