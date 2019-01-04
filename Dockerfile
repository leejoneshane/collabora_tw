FROM ubuntu:16.04

ENV domain localhost

ADD start-libreoffice.sh /
RUN chmod +x /*.sh \
    && apt-get update && apt-get -y upgrade \
    && apt-get -y install apt-utils apt-transport-https dialog \
    && echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" > /etc/apt/sources.list.d/collabora.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D \
    && apt-get update \
    && apt-get -y install loolwsd code-brand collaboraoffice6.0-dict* collaboraofficebasis6.0* inotify-tools psmisc \
    && apt-get -y install locales locales-all fonts-linuxlibertine ttf-linux-libertine \
    && locale-gen zh_TW.utf8 \
    && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install msttcorefonts \
    && fc-cache -f -v \
    && cp -Rp /usr/share/fonts/truetype/msttcorefonts/* /opt/collaboraoffice6.0/share/fonts/truetype \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL zh_TW.UTF-8
ENV LANG zh_TW.UTF-8
WORKDIR /usr/share/loolwsd

EXPOSE 9980

CMD /start-libreoffice.sh
