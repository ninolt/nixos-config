# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Declarative NixOS configuration for a single personal dev laptop (hostname `nixos`, `x86_64-linux`), built with Nix Flakes + Home Manager. `/etc/nixos` is a symlink to this repo, so the config can be edited from either path.

## Commands

```sh
# Apply config changes (builds + switches to new generation)
sudo nixos-rebuild switch --flake /etc/nixos
# equivalent shell alias (defined in home/zsh.nix): `update`

# Garbage-collect old generations older than 10 days
sudo nix-collect-garbage --delete-older-than 10d
# alias: `delold`

# Edit/create an agenix secret
nix run github:ryantm/agenix -- -e secret_file_name.age
```

There is no test suite or linter; the only validation is whether `nixos-rebuild switch` (or `nixos-rebuild build` for a dry run) succeeds.

## Architecture

The flake (`flake.nix`) wires together one `nixosConfigurations.nixos` system from:

- `configuration.nix` — core system config (bootloader, networking, locale/`fr` keyboard, services like `greetd`+`sway`, pipewire, podman, printing, bluetooth, tailscale, kdeconnect firewall ports). Imports `hardware-configuration.nix`, `./dev`, and `system.nix`.
- `system.nix` — standalone system-level extras unrelated to hardware/boot: agenix secret declarations (`age.secrets`) and a systemd timer that pings an ntfy server (via a VPS domain + token stored as agenix secrets) to nag for a reboot after 3 days of uptime.
- `dev/` — system-wide dev tooling as NixOS modules (not Home Manager), aggregated via `dev/default.nix`. Add a new language/toolchain by creating `dev/<tool>.nix` and importing it there.
- `home/` — Home Manager config for user `nino`, entry point `home/home.nix`, which imports one module per concern (`sway/`, `zsh.nix`, `waybar.nix`, `firefox/`, `dev/`, `joplin/`, `nextcloud.nix`, `spotify.nix`, etc.). Each subdirectory is self-contained (its own `default.nix`); flat `.nix` files are single-purpose modules.
  - `home/dev/default.nix` — user-level dev tools: Claude Code, opencode, git (with lfs), Neovim (gruvbox theme, pylsp via `initLua`, nvim-cmp/lspconfig).
  - Desktop environment is swayfx (via the `swayfx` flake input) + waybar + wofi + dunst + alacritty, Gruvbox-themed throughout.
- `secrets/` — agenix-encrypted secrets. `secrets.nix` maps each `*.age` file to the SSH public keys (user + this system) allowed to decrypt it. Never read/decrypt the `.age` files directly; manage them with the `agenix` CLI command above.

Flake inputs follow the system `nixpkgs` (`inputs.nixpkgs.follows`) to avoid duplicate package sets: `home-manager`, `agenix`, `swayfx`, `spicetify-nix`.

## Conventions

- New system-wide packages/services go in `configuration.nix` (or a new file imported from it); user-facing dotfiles/packages go under `home/`.
- A module that only needs `pkgs`/`lib` should take exactly `{ pkgs, lib, ... }` (or a subset), matching the existing files.
- Secrets (tokens, domains) must go through agenix (`secrets/*.age` + an entry in `secrets.nix`), never hardcoded into `.nix` files.
