#!/bin/sh
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Fix domain name resolution from jails
cp /etc/resolv.conf /etc/hosts /opt/lool/systemplate/etc/

SAL_LOG="-INFO-WARN"

# Backward compatible way to pass configuration settings with environment variables
# These environemt variables are documented at various places so we keep support of them.
[ -z ${domain} ] || extra_params="${extra_params} --o:storage.wopi.host[0]=${domain}"
[ -z ${username} ] || extra_params="${extra_params} --o:admin_console.username=${username}"
[ -z ${password} ] || extra_params="${extra_params} --o:admin_console.password=${password}"
[ -z ${server_name} ] || extra_params="${extra_params} --o:server_name=${server_name}"
[ -z ${dictionaries} ] || extra_params="${extra_params} --o:allowed_languages=${dictionaries}"

# Restart when /etc/loolwsd/loolwsd.xml changes
[ -x /usr/bin/inotifywait -a /usr/bin/killall ] && (
  /usr/bin/inotifywait -e modify /etc/loolwsd/loolwsd.xml
  echo "$(ls -l /etc/loolwsd/loolwsd.xml) modified --> restarting"
  /usr/bin/killall -1 loolwsd
) &

# Generate WOPI proof key
loolwsd-generate-proof-key

# Start loolwsd
exec /usr/bin/loolwsd --version --o:sys_template_path=/opt/lool/systemplate --o:child_root_path=/opt/lool/child-roots --o:file_server_root_path=/usr/share/loolwsd --o:logging.color=false --o:user_interface.mode=notebookbar ${extra_params}
