# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:7a568bcee42666f73f041645a41c913ce1d442f4c24cf6019bc543a90820e531 AS builder

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

FROM chainguard/python:latest@sha256:a0365f7b90bf7b78a5e35f2709efb7c9263acf9c7b1905e0ec4c3e943c88e64d

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
