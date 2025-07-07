FROM python:3.13-slim@sha256:6544e0e002b40ae0f59bc3618b07c1e48064c4faed3a15ae2fbd2e8f663e8283

RUN apt-get update \
&& apt-get install gcc -y \
&& apt-get clean

COPY . /usr/src/njsscan

WORKDIR /usr/src/njsscan

RUN pip install -e .

ENTRYPOINT ["njsscan"]