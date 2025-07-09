# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:01dd535bfe0e5be9ab3ab49f25c60c94505db9175e15a3108fc6ff243f65ab4a AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/njsscan/venv/bin:$PATH"

WORKDIR /njsscan
RUN python -m venv /njsscan/venv

COPY . /njsscan

RUN pip install . --no-cache-dir

FROM chainguard/python:latest-dev@sha256:01dd535bfe0e5be9ab3ab49f25c60c94505db9175e15a3108fc6ff243f65ab4a

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-08"
LABEL author="Florian Stosse"
LABEL description="njsscan tool, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"
ENV PATH="/venv/bin:$PATH"

WORKDIR /njsscan

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /njsscan/venv /venv

RUN ls /venv
RUn ls /venv/bin

ENTRYPOINT ["/venv/bin/njsscan"]
