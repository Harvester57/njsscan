# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:79a3c0faff705cfd3963399c9835e079a24b5655883e42171fe1a6bf27e794df AS builder

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

FROM chainguard/python:latest@sha256:80c9b043c8f231f130b0d0dd71cfbdc79e8a9855430ea2fad0ded34de12116c4

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
