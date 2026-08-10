# Selene

## Sobre

Imagem bootc de um sistema imutável baseado no Fedora Silverblue, com GNOME e pacotes adicionais (Steam, Tailscale, virtualização, entre outros).

## Arquitetura

- **Base:** [Fedora Silverblue](https://quay.io/repository/fedora-ostree-desktops/silverblue) (Imagem OCI inicializável Oficial do projeto Fedora, com GNOME).
- **Interface:** GNOME (padrão do Silverblue).
- **Automação:** GitHub Actions com build diário às 03h45 (horário de Brasília) e notificação no telegram.

### Estrutura de Arquivos

```
selene/
├── Containerfile                        # Instruções de build da imagem
├── packages/
│   ├── base                             # Pacotes essenciais e de escolha pessoal
│   └── desktop                          # Pacotes da interface gráfica
├── scripts/
│   ├── first-boot.sh                    # Configuração executada no primeiro boot
│   └── post-install.sh                  # Adiciona Flathub e instala Flatpaks
└── systemd/
    └── post-install.service             # Serviço que executa post-install.sh
```

## Uso

### Rebase

A partir de uma instalação do Fedora Silverblue, é só rodar os seguintes comandos:

```bash
# Fixa o deployment pra ele nunca ser removido automaticamente
sudo ostree admin pin 0

# Mostra a versão atual da imagem
sudo bootc status

# Migra para esta imagem (primeira utilização)
sudo bootc switch ghcr.io/murilomonte/selene:latest

# Para reverter para a imagem anterior
sudo bootc rollback
```

> Com o deployment fixado, o Silverblue puro continua disponível como opção no GRUB pra sempre (até você rodar `sudo ostree admin pin --unpin <índice>`), independente de quantas vezes você trocar de imagem depois.

## Manutenção

```bash
# Verificar se há nova imagem disponível
sudo bootc upgrade --check

# Aplicar a atualização
sudo bootc upgrade

# Após reiniciar, verificar o que mudou
rpm-ostree db diff

# Reiniciar para ativar a nova imagem
sudo reboot
```

## Agradecimentos

- [Fedora](https://docs.fedoraproject.org/en-US/bootc/) pelo sistema base.
- [Ferlinuxdebian/bootc-gnome-minimal](https://github.com/Ferlinuxdebian/bootc-gnome-minimal) pelo projeto que serviu de inspiração e ponto de partida.

***

Moonlight guide us... 🌙
