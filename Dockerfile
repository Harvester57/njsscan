FROM python:3.14-rc-slim

RUN apt-get update \
&& apt-get install gcc -y \
&& apt-get clean

COPY . /usr/src/njsscan

WORKDIR /usr/src/njsscan

RUN pip install -e .

ENTRYPOINT ["njsscan"]