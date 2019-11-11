FROM python:3.8.0-alpine3.10
WORKDIR /app

RUN apk --update add build-base gcc abuild binutils linux-headers libffi-dev \
    bash curl && \
  rm -rf /tmp/* /var/cache/apk/*

COPY requirements.txt /app
COPY .pylintrc /root/
RUN pip install --upgrade pip && pip install -r /app/requirements.txt
