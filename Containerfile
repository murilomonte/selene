# Primeiro estágio: Construção do ambiente com os drivers NVIDIA
# Imagem dividida em dois estágios para otimizar o tamanho final da imagem
FROM quay.io/fedora/fedora-bootc:44 AS builder

# Imagem final: Configuração do ambiente de desktop e instalação dos drivers NVIDIA
FROM quay.io/fedora/fedora-bootc:44 AS final
LABEL ostree.bootable="true"
LABEL containers.bootc="1"
COPY locale.conf post-install.sh pacotes_desktop pacotes_necessarios post-install.service vconsole.conf zram-generator.conf greetd.toml first-boot.sh first-boot.service ./
RUN mkdir -vp /var/roothome /data /var/home && \
    dnf5 -y upgrade --refresh && \
    dnf5 -y install kernel-modules-extra --refresh && \
    printf 'omit_dracutmodules+=" nfs "\nomit_drivers+=" nfs nfsv3 nfsv4 nfs_acl nfs_common sunrpc rxrpc rpcrdma auth_rpcgss rpcsec_gss_krb5 "\n' | tee /etc/dracut.conf.d/no-nfs.conf && \
    kver="$(rpm -q kernel-core --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')" && \
    dracut -f /usr/lib/modules/${kver}/initramfs.img ${kver} && \
    dnf5 -y install wget && \
    mv -v zram-generator.conf /etc/systemd/ && \
    rm -rvf /opt && mkdir -vp /var/opt && ln -vs /var/opt /opt && \
    mkdir -vp /var/usrlocal && mv -v /usr/local/* /var/usrlocal/ && \
    rm -rvf /usr/local && ln -vs /var/usrlocal /usr/local && \
    mv -v vconsole.conf /etc/vconsole.conf && \
    mv -v locale.conf /etc/locale.conf && \
    mv -v post-install.sh /usr/bin/post-install.sh && \
    mv -v post-install.service /usr/lib/systemd/system/post-install.service && \
    chmod +x /usr/bin/post-install.sh && \
    systemctl enable post-install.service && \
    mv -v first-boot.sh /usr/bin/first-boot.sh && \
    mv -v first-boot.service /usr/lib/systemd/system/first-boot.service && \
    chmod +x /usr/bin/first-boot.sh && \
    systemctl enable first-boot.service && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/*

# Adiciona o repositório Terra
# RUN dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y && \
#     dnf5 clean all

# Adiciona o COPR do Hyprland (necessario para o noctalia v5)
# RUN dnf5 install dnf5-plugins -y && \
#     dnf5 copr enable lionheartp/Hyprland -y && \
#     dnf5 clean all

# Adiciona o COPR do Dank
RUN dnf5 install dnf5-plugins -y && \
    dnf5 copr enable avengemedia/danklinux -y && \
    dnf5 copr enable avengemedia/dms -y && \
    dnf5 clean all

# Instalação do niri com o noctalia
RUN dnf5 install dms niri --exclude=waybar,alacritty -y && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/*

# instalação dos pacotes necessários para o ambiente de desktop e a base
RUN grep -v '^#' pacotes_necessarios | tr '\n' ' ' | xargs dnf5 install -y && \
    grep -v '^#' pacotes_desktop | tr '\n' ' ' | xargs dnf5 install -y && \
    systemctl mask systemd-remount-fs.service && \
    systemctl mask akmods-keygen@akmods-keygen.service && \
    systemctl mask rtkit-daemon.service && \
    systemctl enable libvirtd.service && \
    systemctl enable spice-vdagentd.service && \
    mkdir -vp /etc/greetd && mv -v greetd.toml /etc/greetd/config.toml && \
    systemctl enable greetd.service && \
    systemctl --global enable dms && \
    rm -fv pacotes_necessarios pacotes_desktop && \
    dnf5 clean all && \
    rm -rfv /var/cache/* \
    /var/lib/* \
    /var/log/* \
    /var/tmp/* \
    /var/usrlocal/share/applications/mimeinfo.cache \
    /var/roothome/.*

RUN systemd-sysusers

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
    --output oci:/run/src/out

FROM oci:out
LABEL ostree.bootable="true"
LABEL containers.bootc="1"

