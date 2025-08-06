# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:b75d0c87f3a7ffe86ab330009d78a3d2d1c7f1b5cd784bdf8429ff9882192622 AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan
RUN python -m venv venv
ENV PATH="/njsscan/venv/bin:$PATH"

COPY . /njsscan

RUN pip install . --no-cache-dir

FROM chainguard/python:latest-dev@sha256:b75d0c87f3a7ffe86ab330009d78a3d2d1c7f1b5cd784bdf8429ff9882192622

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-08"
LABEL author="Florian Stosse"
LABEL description="njsscan tool, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"
ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /njsscan/venv /njsscan/venv
ENV PATH="/njsscan/venv/bin:$PATH"

RUN njsscan

ENTRYPOINT ["njsscan"]
