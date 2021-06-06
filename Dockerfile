FROM python:3-slim

RUN pip3 install --no-cache-dir --upgrade requests==2.19              && \
    apt-get update                                                    && \
    apt-get install -y git build-essential libssl-dev zlib1g-dev curl && \
    mkdir /build                                                      && \
    cd /build                                                         && \
    git clone https://github.com/lhpmain/MTProxy .                    && \
    git reset --hard 1a6fee3d4ff2f7817dd79689fd243280c794c373         && \
    make                                                              && \
    mkdir /server                                                     && \
    cp /build/objs/bin/* /server                                      && \
    cd /server                                                        && \
    rm -rf /build                                                     && \
    apt-get purge -y git build-essential libssl-dev zlib1g-dev        && \
    apt-get autoremove -y                                             && \
    apt-get clean                                                     && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY src /src
CMD ["/src/entry.sh"]
