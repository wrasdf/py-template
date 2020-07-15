## base image
FROM python:3.8.3-slim-buster AS base
ENV KUBERNETES_VERSION=1.16.12
WORKDIR /app

## install non-python dependencies
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends curl jq=1.5* && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN curl -L -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
    chmod a+x /usr/bin/kubectl

## virtual env setup
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
RUN pip install --upgrade pip && pip install wheel pip-tools
COPY requirements/app.txt ./requirements/app.txt
RUN pip install -r ./requirements/app.txt

FROM base AS lint
COPY ./requirements/lint.txt ./requirements/
RUN pip install -r ./requirements/lint.txt

FROM base AS test
COPY ./requirements/test.txt ./requirements/
RUN pip install -r ./requirements/test.txt

FROM python:3.8.3-slim-buster AS release
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends jq=1.5* && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
COPY --from=base /opt/venv /opt/venv
COPY --from=base /usr/bin/kubectl /usr/bin/kubectl
WORKDIR /app

## add user
RUN addgroup --system user && adduser --system --no-create-home --group user
RUN chown -R user:user /app && chmod -R 755 /app

## switch to non-root user
USER user

## add app
COPY ./ /app

## set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONPATH="/app"

ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=5000"]
