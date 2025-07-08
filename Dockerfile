# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:26eaa7a1a5baafb4c00bee9f1fbd744419290facf2ff2d6e1021c7b63a5b471d AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/njsscan/venv/bin:$PATH"

WORKDIR /njsscan
RUN python -m venv /njsscan/venv

COPY . /njsscan

RUN pip install -e . --no-cache-dir

FROM chainguard/python:latest@sha256:e0dbf1d2dd8116bc4c5b9066281b1939777eba163e7e7801d3d34fc8ebe5bedb

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-08"
LABEL author="Florian Stosse"
LABEL description="njsscan tool, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /njsscan

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /njsscan/venv /venv

ENTRYPOINT ["njsscan"]
