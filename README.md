# Selene

## Sobre

Imagem bootc de um sistema imutável baseado no Fedora utilizando Niri e Dank Material Shell, com alguns pacotes adicionais, como Tailscale.

## Arquitetura

- **Base:** [fedora-bootc](https://quay.io/repository/fedora/fedora-bootc) (Imagem OCI inicializável Oficial do projeto Fedora).
- **Interface:** Niri com Dank Material Shell.
- **Automação:** GitHub Actions com build diário às 03h45 (horário de Brasília) e notificação no telegram.

### Estrutura de Arquivos

```
selene/
├── Containerfile                        # Instruções de build da imagem
├── anaconda/
│   └── config.toml                      # Kickstart do Anaconda para geração de ISO
├── config/
│   ├── locale.conf                      # Localidade do sistema (pt-BR)
│   ├── vconsole.conf                    # Configuração do TTY (pt-BR)
│   ├── zram-generator.conf              # zram com tamanho da RAM e compressão zstd
│   └── greetd.toml                      # Configuração do greeter greetd
├── packages/
│   ├── base                             # Pacotes essenciais e de escolha pessoal
│   └── desktop                          # Pacotes da interface gráfica
├── scripts/
│   ├── first-boot.sh                    # Configuração executada no primeiro boot
│   └── post-install.sh                  # Adiciona Flathub e instala Flatpaks
├── systemd/
│   ├── first-boot.service               # Serviço que executa first-boot.sh
│   ├── post-install.service             # Serviço que executa post-install.sh
│   ├── bootc-upgrade-silent.service     # Serviço de atualização silenciosa
│   └── bootc-upgrade-silent.timer       # Timer para atualização automática
└── usr/lib/udev/rules.d/
    └── 99-disable-xhci-wakeup.rules     # Desabilita wakeup via USB 3.0
```

## Uso

## ISO

Uma ISO é gerada automáticamente pelo github actions.

- Entre na aba actions
- Selecione o workflow
- Baixe a ISO na seção de artefatos.
- Use a ISO para instalar como qualquer sistema linux.

## Rebase

Uma vez que você esteja em algum Fedora Atomico, é só rodar os seguintes comandos:

```bash
# Ver a versão atual da imagem
sudo bootc status

# Migrar para esta imagem (primeira utilização)
sudo bootc switch ghcr.io/murilomonte/selene:latest

# Para reverter para a imagem anterior
sudo bootc rollback
```

### Manutenção

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

- [Fedora bootc](https://docs.fedoraproject.org/en-US/bootc/) pelo sistema base.
- [Ferlinuxdebian/bootc-gnome-minimal](https://github.com/Ferlinuxdebian/bootc-gnome-minimal) pelo projeto base do qual este se baseia.
- [gzSoares/dank](https://github.com/gzSoares/dank) de onde tirei algumas inspirações.
- [joshyorko/omarchy-bootc](https://github.com/joshyorko/omarchy-bootc) por alguns componentes.

***

Moonlight guide us... 🌙
