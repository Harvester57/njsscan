# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:251bebc53d005d78dddb22dee13fea68a86a5246bf65ade877f0529b78e2f14a AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /njsscan
RUN python -m venv venv
ENV PATH="/njsscan/venv/bin:$PATH"

COPY . /njsscan

RUN pip install . --no-cache-dir

FROM chainguard/python:latest-dev@sha256:251bebc53d005d78dddb22dee13fea68a86a5246bf65ade877f0529b78e2f14a

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
