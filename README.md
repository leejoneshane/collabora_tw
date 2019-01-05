# collabora_tw
Enhance the following features for the original collabora/code image:
- generated and set default locale for zh_TW.UTF-8
- preinstall microsoft truetype chinese fonts
- disable SSL and turn on ssl.termination, because if it run in docker swarm mode, it will behind the reverse proxy.
- set workdir to /usr/share/loolwsd for developer.

## about Collabora/CODE
Usage and possible settings are documented on the [CODE home page](https://collaboraoffice.com/code/).
