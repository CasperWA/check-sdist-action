FROM python:alpine

COPY entrypoint.sh .

ENTRYPOINT [ "entrypoint.sh" ]
