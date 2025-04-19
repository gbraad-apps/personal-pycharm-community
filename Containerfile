ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN URL="https://download.jetbrains.com/python/pycharm-2025.1.tar.gz" \
    && INSTALL_DIR="/opt/pycharm" \
    && mkdir -p "$INSTALL_DIR" \
    && curl -L "$URL" -o /tmp/pycharm.tar.gz \
    && tar --strip-components=1 -xzf /tmp/pycharm.tar.gz -C "$INSTALL_DIR" \
    && rm /tmp/pycharm.tar.gz

RUN git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.title "PyCharm 2025.1" \
    && git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.exec "/opt/pycharm/bin/pycharm.sh"

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
