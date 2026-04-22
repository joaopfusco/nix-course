# Nix Course

Material de apoio para o curso de Nix.

## Instalação do Nix

**Opção 1** — Instalador oficial (requer habilitar flakes manualmente):
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

**Opção 2** — Determinate Systems (recomendado):
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Habilitar Flakes (Opção 1)

```sh
sudo nano /etc/nix/nix.conf
```

Adicione a linha:
```
experimental-features = nix-command flakes
```

Reinicie o daemon:
```sh
sudo systemctl restart nix-daemon
nix flake --help
```

### Habilitar Pacotes Unfree

Por padrão o Nix bloqueia pacotes com licenças não livres (ex: Discord, Slack, VS Code).

**1. Temporariamente (por comando):**

```sh
NIXPKGS_ALLOW_UNFREE=1 nix-shell -p discord
```

Para os novos comandos `nix` (nix3), adicione `--impure`:

```sh
NIXPKGS_ALLOW_UNFREE=1 nix profile install nixpkgs#discord --impure
```

**2. Permanentemente para seu usuário:**

Crie/edite `~/.config/nixpkgs/config.nix` com o conteúdo:

```nix
{ allowUnfree = true; }
```

## Instalação do direnv

| Distro       | Comando                           |
|--------------|-----------------------------------|
| Fedora       | `sudo dnf install direnv`         |
| Ubuntu       | `sudo apt install direnv`         |
| Nix (Flakes) | `nix profile add nixpkgs#direnv`  |

Após instalar, adicione ao `~/.bashrc`:

```sh
eval "$(direnv hook bash)"
```

Recarregue o shell:

```sh
source ~/.bashrc
```

## Comandos

| Arquivo     | Comando        |
|-------------|----------------|
| `shell.nix` | `nix-shell`    |
| `flake.nix` | `nix develop`  |

### Usando zsh dentro do shell

```sh
nix-shell --run zsh
nix develop -c zsh
```

### Verificar se está no shell do Nix

```sh
echo $IN_NIX_SHELL  # retorna: impure
```

## Links Úteis

- [Pesquisar pacotes](https://search.nixos.org/packages)
- [nixpkgs no GitHub](https://github.com/NixOS/nixpkgs)
- [FlakeHub](https://flakehub.com/flakes)
- [NixOS/nixpkgs no FlakeHub](https://flakehub.com/flake/NixOS/nixpkgs?view=usage)

### Referências de flake inputs

```
github:nixos/nixpkgs/nixos-unstable
github:nixos/nixpkgs/nixos-25.11  # stable
```

## Meus Repositórios

- [nix-config](https://github.com/joaopfusco/nix-config)
- [nix-course](https://github.com/joaopfusco/nix-course)
