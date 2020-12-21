FROM ubuntu

ENV domain localhost
ENV corever 6.4
ENV LC_ALL zh_TW.UTF-8
ENV LANG zh_TW.UTF-8

ADD start-libreoffice.sh /
RUN chmod +x /*.sh \
    && apt-get update \
    && ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata locales locales-all \
    && locale-gen "zh_TW.UTF-8" \
    && apt-get -y install software-properties-common apt-utils apt-transport-https gnupg2 ca-certificates \
    && add-apt-repository -y ppa:linuxuprising/libpng12 \
    && add-apt-repository -y ppa:rael-gc/rvm \
    && echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" > /etc/apt/sources.list.d/collabora.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D \
    && apt-get update \
    && apt-get -y install libpng12-0 rvm \
    && /usr/share/rvm/scripts/rvm install libssl1.0.0 \
    && apt-get -y install loolwsd code-brand collaboraoffice$corever-dict-* collaboraofficebasis$corever-* inotify-tools psmisc \
    && apt-get -y install fonts-linuxlibertine \
    && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install msttcorefonts fontconfig \
    && fc-cache -f -v \
    && cp -Rp /usr/share/fonts/truetype/msttcorefonts/* /opt/collaboraoffice$corever/share/fonts/truetype \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/share/loolwsd

EXPOSE 9980

CMD /start-libreoffice.sh
