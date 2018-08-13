#
# Dockerfile
#
# 2018/08/13 - First release
#
FROM alpine:3.7

# Install core components
RUN apk add --update \
    bash \
    python \
    python-dev \
    py-pip \
    build-base \
    git \
  && pip install --upgrade pip \
  && rm -rf /var/cache/apk/*

# Install application
WORKDIR /opt/
RUN pip install configobj
RUN wget https://github.com/marcelosz/OpenDXL-Anomali-STAXX/releases/download/v1.0-beta.2/OpenDXL-Anomali-STAXX-1.0-beta.2.zip \
    && unzip OpenDXL-Anomali-STAXX-1.0-beta.2.zip \ 
    && mv OpenDXL-Anomali-STAXX-1.0-beta.2 OpenDXL-Anomali-STAXX
RUN wget https://github.com/opendxl/opendxl-client-python/releases/download/4.1.0.185/dxlclient-python-sdk-4.1.0.185.zip \
    && unzip dxlclient-python-sdk-4.1.0.185.zip
WORKDIR /opt/dxlclient-python-sdk-4.1.0.185
RUN pip install lib/dxlclient-4.1.0.185.zip
WORKDIR /opt/OpenDXL-Anomali-STAXX
ADD run.sh /run.sh
RUN chmod 0755 /run.sh

VOLUME /opt/OpenDXL-Anomali-STAXX/conf

ENTRYPOINT ["/run.sh"]
