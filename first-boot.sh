#!/bin/bash
set -e

# Cria o usuário greeter para o greetd se não existir
if ! id greeter &>/dev/null; then
    useradd -r -d /var/lib/greeter -s /sbin/nologin greeter
fi

# Cria o diretório de cache do dms greeter
mkdir -p /var/cache/dms-greeter

mkdir -p /var/lib/selene
touch /var/lib/selene/.firstboot-done
