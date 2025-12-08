# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:2a649c948b4bb7a5950845a4adadbf98032b68e4544ead60472ba52f3c7365fb AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan
COPY . .

WORKDIR /action
RUN python3 -m venv /action && source /action/bin/activate && python3 -m pip install --upgrade pip
RUN /action/bin/pip3 install /njsscan
ENV PATH="/action/bin:$PATH"

USER root
RUN rm -rf /njsscan

USER nonroot

FROM chainguard/python:latest@sha256:ca9d5a51ade3c4d541e73be4a7357d45421f13c431c2a74c8202c116261326f9

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-08-06"
LABEL author="Florian Stosse"
LABEL description="njsscan tool, built using Python Chainguard based image"
LABEL license="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"

COPY --from=builder /action /action
ENV PATH="/action/bin:$PATH"

ENTRYPOINT [ "python3", "/action/bin/njsscan" ]
