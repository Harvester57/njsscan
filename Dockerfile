# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:01dd535bfe0e5be9ab3ab49f25c60c94505db9175e15a3108fc6ff243f65ab4a AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan
COPY . /njsscan

RUN pip install . --no-cache-dir

RUN ls -ailh /njsscan
RUN njsscan
