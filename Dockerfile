FROM ubuntu:16.04

ENV domain localhost
ENV LC_ALL zh_TW.UTF-8
ENV LANG zh_TW.UTF-8

ADD /scripts/install-libreoffice.sh /
ADD /scripts/start-libreoffice.sh /
RUN bash install-libreoffice.sh

EXPOSE 9980

CMD bash start-libreoffice.sh
