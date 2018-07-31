FROM python:alpine3.7
WORKDIR /app

RUN apk --update add build-base gcc abuild binutils linux-headers libffi-dev \
    make bash jq curl && \
  rm -rf /tmp/* /var/cache/apk/*

COPY requirements.txt /app
COPY .pylintrc /app
RUN pip install --upgrade pip && pip install -r /app/requirements.txt
