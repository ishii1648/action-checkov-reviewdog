FROM python:3.12-slim

ARG REVIEWDOG_VERSION="v0.16.0"
ENV PATH $PATH:/usr/local/bin

RUN apt-get update && \
    apt-get install -y git curl

RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "/usr/local/bin/" "${REVIEWDOG_VERSION}" 2>&1

COPY requirements.txt /requirements.txt
COPY parse.py /parse.py
COPY entrypoint.sh /entrypoint.sh

RUN pip install -r /requirements.txt

ENTRYPOINT ["/entrypoint.sh"]