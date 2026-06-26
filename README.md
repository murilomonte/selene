# Selene

## Sobre

Imagem bootc de um sistema imutável baseado no Fedora 44 utilizando Niri e Dank Material Shell, com alguns pacotes adicionais, como Tailscale.

## Arquitetura

- **Base:** [fedora-bootc](https://quay.io/repository/fedora/fedora-bootc) (Imagem OCI inicializável Oficial do projeto Fedora).
- **Interface:** Niri com Dank Material Shell.
- **Automação:** GitHub Actions com build diário às 03h45 (horário de Brasília) e notificação no telegram.

### Estrutura de Arquivos

| Arquivo | Função |
|---|---|
| `Containerfile` | Instruções de build da imagem (instalação de pacotes e drivers) |
| `pacotes_desktop` | Lista de pacotes relacionados à interface gráfica (GNOME, Plasma e afins) |
| `pacotes_necessarios` | Lista de pacotes essenciais ao sistema, acrescida de pacotes de escolha pessoal |
| `post-install.sh` | Script de pós-instalação: remove o repositório Fedora Flatpak, adiciona o Flathub e instala os Flatpaks |
| `.github/workflows` | Arquivo `.yml` responsável pelo build automático via GitHub Actions |
| `post-install.service` | Serviço systemd que executa o script de pós-instalação no primeiro boot |
| `vconsole.conf` | Configuração do TTY para pt-BR |
| `locale.conf` | Configuração de localidade do sistema para pt-BR |
| `config.toml` | Arquivo de kickstart do Anaconda para geração de ISO de instalação |
| `zram-generator.conf` | Configura o zram com tamanho igual ao da RAM, usando o algoritmo de compressão zstd |
| `greetd.toml` | Arquivo para configuração do greetd |
| `first-boot.service` e `first-boot.sh` | Arquivos para auxílio da configuração do greetd |

## Uso

## Primeiro uso

Uma vez que você esteja em algum Fedora Atomico, é só rodar os seguintes comandos:

```bash
# Ver a versão atual da imagem
bootc status

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

![Selene](/assets/selene.webp)

Moonlight guide us... 🌙
