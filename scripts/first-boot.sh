#!/bin/bash
set -e

# Cria o usuário greeter para o greetd se não existir
if ! id greeter &>/dev/null; then
    useradd -r -d /var/lib/greeter -s /sbin/nologin greeter
fi

# Cria o diretório de cache do dms greeter
mkdir -p /var/cache/dms-greeter

# Cria diretórios XDG (Documentos, Downloads, etc.) para o usuário principal
user=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {print $1; exit}')
if [ -n "$user" ] && [ ! -f "/home/$user/.config/user-dirs.dirs" ]; then
    runuser -l "$user" -c "xdg-user-dirs-update"
fi

