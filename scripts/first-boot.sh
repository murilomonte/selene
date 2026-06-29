#!/bin/bash
set -e

# Cria diretórios XDG (Documentos, Downloads, etc.) para o usuário principal
user=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {print $1; exit}')
if [ -n "$user" ] && [ ! -f "/home/$user/.config/user-dirs.dirs" ]; then
    runuser -l "$user" -c "xdg-user-dirs-update"
fi

