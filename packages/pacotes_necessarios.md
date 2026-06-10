# pacotes_necessarios

Lista de pacotes essenciais e não-essenciais para a imagem bootc. Instalada no Containerfile via `dnf5 install`.

---

## Essenciais

### `@networkmanager-submodules`
Grupo de componentes do NetworkManager (cliente CLI `nmcli`, applet `nm-applet`, dispatcher). Necessário para gerenciar redes via terminal ou bandeja do sistema.

### `@multimedia`
Grupo com codecs multimídia, GStreamer e plugins. Essencial para reprodução de áudio/vídeo.

### `ffmpegthumbnailer`
Gerador de miniaturas de vídeo usando FFmpeg. Necessário para que gerenciadores de arquivos (Nautilus etc.) mostrem previews de vídeos.

### `xdg-utils`
Utilitários XDG (`xdg-open`, `xdg-mime`, etc.). Essencial para associar aplicativos a tipos de arquivo e abrir URLs corretamente.

### `compsize`
Ferramenta CLI para ver a taxa de compressão de arquivos em Btrfs. Útil para monitorar o quanto a compressão está economizando.

### `langpacks-core-pt_BR`
Pacotes de idioma coreano para português brasileiro em aplicações, menus e data/hora.

### `flatpak`
Estrutura básica do Flatpak. Necessário para instalar e rodar Flatpaks do Flathub.

### `git`
Sistema de versionamento. Útil para desenvolvimento, clonar repositórios e scripts.

### `tree`
Exibe diretórios em árvore no terminal. Útil para inspecionar a estrutura de arquivos.

### `langpacks-fonts-pt`
Fontes com suporte a acentos do português. Garante que caracteres como Ã, Ç, ã apareçam corretamente.

### `langpacks-pt_BR`
Traduções e locale do Fedora para português brasileiro.

### `tuned`
Daemon de perfil de performance da Red Hat. Ajusta CPU, disco, rede para economia/performance conforme o perfil.

### `tuned-ppd`
Camada de compatibilidade entre `tuned` e a API do `power-profiles-daemon`. Permite que apps GNOME/KDE controlem perfis de energia usando o `tuned` como backend. Padrão no Fedora 41+.

### `zram-generator`
Gera dispositivo ZRAM (RAM comprimida como swap). Configurado via `zram-generator.conf` para criar swap na RAM, reduzindo I/O em disco.

### `spice-vdagent`
Agente SPICE para VMs. Necessário para integração de mouse, redimensionamento de tela e área de transferência em máquinas virtuais.

### `podman`
Mecanismo de contêiner rootless. Alternativa ao Docker, padrão no Fedora. Usado para rodar contêineres e pelo Distrobox.

### `fpaste`
CLI para enviar texto/logs ao Fedora Pastebin. Útil para compartilhar logs em pedidos de ajuda.

### `auditctl`
Ferramenta do Linux Audit Framework para configurar regras de auditoria do kernel. Parte do `auditd`.

### `unzip`
Descompactador de arquivos ZIP.

### `usbutils`
Utilitários USB (`lsusb`, `usbview`). Essencial para listar e depurar dispositivos USB.

### `sysfsutils`
Utilitário `systool` para consultar o sysfs (árvore de dispositivos do kernel). Útil para depuração de hardware.

---

## Não-essenciais

### `@virtualization`
Grupo de pacotes de virtualização (libvirt, qemu, virt-manager). Permite rodar VMs.

### `distrobox`
Wrapper do Podman que cria contêineres integrados ao host. Permite usar outras distros dentro do terminal.

### `featherpad`
Editor de texto leve (Qt). Alternativa leve ao Gedit.

### `btrfs-assistant`
Interface gráfica para gerenciar subvolumes, snapshots, scrub e balance do Btrfs. Útil se usar Snapper.

### `micro`
Editor de texto terminal com atalhos familiares (Ctrl+S, Ctrl+C). Alternativa moderna ao Nano/Vim.

### `nvtop`
Monitor de GPU em tempo real no terminal. Funciona com Nvidia, AMD e Intel.

### `xclip`
Ferramenta CLI para acessar a área de transferência do X11/Wayland. Útil em scripts.

### `ps_mem`
Script Python que mostra uso de RAM por processo de forma mais precisa que `ps`.

### `copyq`
Gerenciador de clipboard com histórico. Permite copiar/colar múltiplos itens.

### `ripgrep` (rg)
Grep moderno e extremamente rápido, ideal para buscar texto em código.

### `bash-color-prompt`
Prompt colorido para Bash via `LS_COLORS` e `PS1`. Melhora a legibilidade do terminal.

### `fira-code-fonts`
Fonte monoespaçada com ligaduras (->, >=, etc.). Excelente para terminal e editores de código.

### `btop`
Monitor de sistema no terminal com gráficos visuais (CPU, RAM, disco, rede, GPU).

### `fastfetch`
Ferramenta de exibição de informações do sistema. Alternativa rápida ao Neofetch.

### `adw-gtk3-theme`
Tema GTK3 que adapta apps GTK3 ao visual Libadwaita (GNOME moderno). Mantém consistência visual.

### `gum`
Ferramenta para escrever scripts shell com estilos, prompts e spinners. Útil para criar scripts CLI bonitos.
