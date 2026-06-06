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

echo "==> Configurando swap para hibernação..."
sudo mkdir -p /swap
sudo btrfs subvolume create /swap 2>/dev/null || true
sudo btrfs filesystem mkswapfile --size 16g /swap/swapfile
sudo swapon /swap/swapfile
grep -q '/swap/swapfile' /etc/fstab || echo '/swap/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

echo "==> Configurando rEFInd para hibernação..."
SWAP_UUID=$(findmnt -no UUID -T /swap/swapfile)
SWAP_OFFSET=$(sudo btrfs inspect-internal map-swapfile -r /swap/swapfile)
sudo cp ~/dotfiles/boot/refind_linux.conf /boot/refind_linux.conf
sudo sed -i "s/resume=UUID=[^ ]*/resume=UUID=$SWAP_UUID/" /boot/refind_linux.conf
sudo sed -i "s/resume_offset=[^ ]*/resume_offset=$SWAP_OFFSET/" /boot/refind_linux.conf

echo "==> Aplicando wallpapers..."
mkdir -p ~/Imagens
cp ~/dotfiles/wallpapers/* ~/Imagens/

echo "==> Regenerando initramfs..."
sudo mkinitcpio -P

echo "==> Pronto!"
