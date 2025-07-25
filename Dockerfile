# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:1cd33a5007bf8a9e62110ae7345eff5073442869b1aba130ee36ee3f3e0bb6ae AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan
RUN python -m venv venv
ENV PATH="/njsscan/venv/bin:$PATH"

COPY . /njsscan

RUN pip install . --no-cache-dir

FROM chainguard/python:latest-dev@sha256:1cd33a5007bf8a9e62110ae7345eff5073442869b1aba130ee36ee3f3e0bb6ae

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
