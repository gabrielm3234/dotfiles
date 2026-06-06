#!/bin/bash
# ╔══════════════════════════════════════════╗
# ║     Gabriel's Dotfiles Install Script    ║
# ╚══════════════════════════════════════════╝

set -e

echo "==> Instalando pacotes..."

# Pacotes principais
sudo pacman -S --needed \
  stow git base-devel \
  hyprland \
  alacritty \
  fish \
  zerotier-one \
  gamemode lib32-gamemode \
  refind \
  pipewire pipewire-pulse wireplumber \
  imagemagick \
  ufw \
  nmap \
  neofetch \
  flatpak

# AUR (yay)
if ! command -v yay &>/dev/null; then
  echo "==> Instalando yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si
fi

yay -S --needed \
  sunshine \
  vesktop-bin \
  bun \
  quickshell \
  noctalia

echo "==> Aplicando dotfiles..."
cd ~/dotfiles
stow hypr noctalia fish alacritty

echo "==> Configurando serviços..."
sudo systemctl enable zerotier-one
sudo loginctl enable-linger $USER
systemctl --user enable --now gamemoded

echo "==> Pronto!"
