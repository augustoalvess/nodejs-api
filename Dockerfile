FROM ubuntu:xenial

# Utilities
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y apt-transport-https software-properties-common unzip curl git vim --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# Change image time zone
ENV TZ 'America/Sao_Paulo'
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update && \
    apt-get -y install nodejs --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# Volume
RUN mkdir /api
VOLUME ["/api"]
WORKDIR /api
COPY . .
EXPOSE 3000