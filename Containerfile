FROM quay.io/fedora-ostree-desktops/silverblue:44 AS final
LABEL ostree.bootable="true"
LABEL containers.bootc="1"

# Atualiza os pacotes da imagem base
RUN dnf5 -y upgrade --refresh && \
    dnf5 clean all

# Serviço de post-install (Flathub e Flatpaks iniciais)
COPY scripts/post-install.sh systemd/post-install.service ./
RUN mv -v post-install.sh /usr/bin/post-install.sh && \
    mv -v post-install.service /usr/lib/systemd/system/post-install.service && \
    chmod +x /usr/bin/post-install.sh && \
    systemctl enable post-install.service && \
    rm -fv post-install.sh post-install.service

# Remoção de pacotes da imagem base
RUN dnf5 remove firefox -y && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/*

# Ativa os repositórios RPM Fusion (necessário para o Steam)
RUN dnf5 install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    dnf5 clean all

# Repositório do Tailscale
RUN dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# Instalação dos pacotes essenciais/base
COPY packages/base ./
RUN grep -v '^#' base | tr '\n' ' ' | xargs dnf5 install -y && \
    rm -fv base && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/*

# Instalação dos pacotes de desktop (GNOME)
COPY packages/desktop ./
RUN grep -v '^#' desktop | tr '\n' ' ' | xargs dnf5 install -y && \
    rm -fv desktop && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/* \
    /var/usrlocal/share/applications/mimeinfo.cache \
    /var/roothome/.*

# Outros
RUN systemctl mask systemd-remount-fs.service

# Verificação da imagem com o bootc container lint
RUN bootc container lint

# Otimização da imagem final usando o chunkah aproveitando layers compartilhados
FROM quay.io/coreos/chunkah AS chunkah
ARG CHUNKAH_CONFIG_STR
RUN --mount=from=final,src=/,target=/chunkah,ro \
    --mount=type=bind,target=/run/src,rw \
    chunkah build --max-layers 128 \
    --label ostree.commit- \
    --label ostree.final-diffid- \
    --prune /sysroot/ \
    --compressed \
    --output oci:/run/src/out

FROM oci:out
LABEL ostree.bootable="true"
LABEL containers.bootc="1"
