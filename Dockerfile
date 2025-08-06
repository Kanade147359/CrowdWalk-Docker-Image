FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    git \
    vim \
    wget \
    gnupg \
    x11-apps \
    software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y \
    openjdk-19-jdk \
    fonts-noto-cjk \
    language-pack-ja && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    export JAVA_OPTS='-Dgroovy.source.encoding=UTF-8 -Dfile.encoding=UTF-8' && \
    git clone https://github.com/crest-cassia/CrowdWalk.git && \
    cd CrowdWalk/crowdwalk && \
    ./gradlew

ENV LANG=ja_JP.UTF-8 \
    JAVA_OPTS='-Dgroovy.source.encoding=UTF-8 -Dfile.encoding=UTF-8'

WORKDIR /CrowdWalk/crowdwalk

CMD [ "bash" ]
