FROM python:alpine

RUN apk add --no-cache git \
    && python -m pip install -U pip \
    && pip install -U setuptools

COPY entrypoint.sh .

ENTRYPOINT [ "entrypoint.sh" ]
