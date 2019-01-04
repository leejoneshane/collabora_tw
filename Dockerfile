FROM ubuntu:16.04

ENV domain localhost

ADD start-libreoffice.sh /
RUN chmod +x /*.sh \
    && echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" > /etc/apt/sources.list.d/collabora.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D \
    && apt-get update && apt-get -y upgrade \
    && apt-get -y install apt-transport-https apt-utils locales locales-all \
    && apt-get -y install fonts-linuxlibertine ttf-linux-libertine ttf-mscorefonts-installer msttcorefonts \
    && apt-get -y install loolwsd code-brand collaboraoffice6.0-dict* collaboraofficebasis6.0* \
    && apt-get -y install inotify-tools psmisc \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen zh_TW.utf8 \
    && fc-cache -f -v

ENV LC_ALL zh_TW.UTF-8
ENV LANG zh_TW.UTF-8

EXPOSE 9980

CMD /start-libreoffice.sh
