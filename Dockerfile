# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:a50c75eaa9a9d0f681029d74f7498258308fe50594f92c7dc6ef3d883f79c570 AS builder

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

FROM chainguard/python:latest@sha256:d409289a0684e02b95c10b586048c465f4032bc31b4055f59f38a73f914e7537

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
