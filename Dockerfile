FROM python:3.13-alpine

RUN apk update && \
    apk upgrade && \
    apk add gcc

COPY . /usr/src/njsscan

WORKDIR /usr/src/njsscan

RUN pip install -e .

ENTRYPOINT ["njsscan"]