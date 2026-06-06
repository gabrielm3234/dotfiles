#!/bin/bash
# ╔══════════════════════════════════════════╗
# ║     Gabriel Dotfiles Install Script      ║
# ╚══════════════════════════════════════════╝

set -e

echo "==> Instalando pacotes oficiais..."
sudo pacman -S --needed \
  stow git base-devel \
  hyprland hypridle hyprlock hyprshot \
  alacritty fish \
  zerotier-one \
  gamemode lib32-gamemode \
  refind \
  pipewire pipewire-alsa pipewire-pulse wireplumber \
  imagemagick \
  ufw ufw-extras \
  btop fastfetch nvtop \
  brave-bin \
  obs-studio \
  kdenlive vlc \
  prismlauncher \
  qbittorrent \
  pavucontrol helvum \
  sddm \
  plymouth \
  openssh \
  bluez bluez-utils \
  networkmanager networkmanager-openvpn \
  podman distrobox \
  lact coolercontrol \
  resources \
  btrfs-assistant btrfs-progs snapper \
  openrazer-daemon openrazer-driver-dkms \
  lib32-mesa lib32-vulkan-radeon lib32-opencl-mesa \
  vulkan-radeon opencl-mesa \
  proton-cachyos \
  ttf-jetbrains-mono-nerd ttf-meslo-nerd \
  wget rsync rclone \
  nano vim micro \
  unzip unrar \
  profile-sync-daemon \
  refind-btrfs

echo "==> Instalando pacotes AUR..."
if ! command -v yay &>/dev/null; then
  echo "==> Instalando yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si
fi

yay -S --needed \
  sunshine \
  vesktop \
  bun-bin \
  curseforge \
  heroic-games-launcher \
  hydra-launcher-bin \
  it87-dkms-git \
  java-openjfx \
  libopenrazer \
  linux-wallpaperengine-git \
  linuxtoys-bin \
  logmein-hamachi \
  mergerfs \
  notepad++ \
  polychromatic \
  razergenie \
  simple-mtpfs \
  udevil \
  womic \
  zramswap \
  quickshell \
  noctalia

echo "==> Aplicando dotfiles..."
cd ~/dotfiles
stow hypr noctalia fish alacritty niri

echo "==> Configurando serviços..."
sudo systemctl enable zerotier-one
sudo systemctl enable sddm
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
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

echo "==> Configurando UFW..."
sudo ufw enable
sudo ufw allow 9993/udp
sudo ufw allow 47984/tcp
sudo ufw allow 47989/tcp
sudo ufw allow 48010/tcp
sudo ufw allow 47998/udp
sudo ufw allow 47999/udp
sudo ufw allow 48000/udp
sudo ufw allow 48002/udp
sudo ufw allow 47990/tcp
sudo ufw allow 1212/tcp
sudo ufw allow 1212/udp

echo "==> Pronto! Reinicie o sistema."
