# pacotes_desktop

Lista de pacotes para o ambiente desktop com niri + DankMaterialShell (DMS). Instalada no Containerfile via `dnf5 install`.

---

### `greetd`
Display manager mínimo e agnóstico. O DMS fornece o comando `dms greeter enable` que configura automaticamente o `/etc/greetd/config.toml` para rodar o DMS em modo greeter, desativa DMs conflitantes e ativa o serviço. Leve, não puxa dependências de desktop.

> Após o primeiro login, execute `dms greeter sync` para configurar permissões ACL e sincronizar temas com o usuário.

---

### `adw-gtk3-theme`
Tema GTK3 que adapta apps GTK3 ao visual Libadwaita (GNOME moderno). Mantém consistência visual entre apps GTK3 e o ecossistema GTK4/Libadwaita que o DMS usa.

### `xwayland-satellite`
Implementação rootless do XWayland. Desde o niri 25.08, é o método oficial e integrado para rodar aplicativos X11 (Steam, apps antigos). O niri não embute XWayland nativamente — delega ao `xwayland-satellite`.

### `xdg-desktop-portal-gnome`
Backend de portais XDG do GNOME. Necessário para funcionalidades como compartilhamento de tela, abrir arquivos, tirar screenshots, etc. Mesmo sem GNOME, é o portal mais completo e compatível.

### `xdg-desktop-portal-gtk`
Backend de portais XDG baseado em GTK. Complementa o portal GNOME, especialmente para apps GTK que usam a interface de "abrir arquivo" nativa.

### `libnma`
Applet GTK do NetworkManager. Fornece o ícone de rede na bandeja do sistema para conectar/desconectar Wi-Fi, VPNs e redes.

### `ibus-typing-booster`
Mecanismo de predição de texto e correção ortográfica para o IBus. Útil para digitação eficiente em português (e outros idiomas).

### `ibus-gtk4`
Módulo de integração do IBus com GTK4. Permite que apps GTK4 usem o IBus corretamente para entrada de texto (acentos, layouts de teclado).

### `nautilus`
Gerenciador de arquivos do GNOME. Integra-se bem com o portal XDG, tem previews, busca, e suporte a Samba/Google Drive. Alternativa: Thunar, pcmanfm-qt.
