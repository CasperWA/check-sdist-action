FROM python:3.9

RUN python -m pip install -U pip \
    && pip install -U setuptools

COPY entrypoint.sh ./
ENTRYPOINT [ "/entrypoint.sh" ]
