FROM ubuntu:20.04

MAINTAINER Quantum Labs, LLC <blake@qlab-innovations.com>

RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    ca-certificates \
    curl

RUN apt-get install -y software-properties-common

RUN apt-get install -y --no-install-recommends \
    make \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev\
    llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev mecab-ipadic-utf8

# Update BashRC PATH to include PyEnv \
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apt-add-repository ppa:git-core/ppa
RUN apt-get -y install git

RUN set -ex \
    && curl https://pyenv.run | bash \
    && pyenv update \
    && pyenv install 3.10.1 \
    && pyenv global 3.10.1 \
    && pyenv rehash

RUN pip --no-cache-dir install flask
# ...ETC

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE

# ENTRYPOINT [....]   # DIY
# CMD [....]          # DIY