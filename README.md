# 🖥️ Gabriel Dotfiles

Configurações pessoais para CachyOS Linux com Hyprland + Noctalia Shell.

## 📦 Programas incluídos

### Interface
- **Hyprland** — compositor Wayland
- **Noctalia Shell** — shell/bar via Quickshell
- **SDDM** — gerenciador de login
- **Alacritty** — terminal
- **Plymouth** — animação de boot

### Aplicativos
- **Firefox** + **Brave** — navegadores
- **Vesktop** — Discord modificado
- **OBS Studio** — gravação/streaming
- **Kdenlive** — edição de vídeo
- **VLC** — player de mídia
- **qBittorrent** — torrents
- **PrismLauncher** — Minecraft
- **CurseForge** — mods Minecraft
- **Heroic** — jogos Epic/GOG
- **Hydra Launcher** — launcher de jogos
- **Notepad++** — editor de texto

### Gaming
- **Proton CachyOS** — camada de compatibilidade Steam
- **GameMode** — otimização de CPU/GPU para jogos
- **Sunshine/Moonlight** — streaming remoto
- **LACT** — controle da GPU AMD
- **CoolerControl** — controle de fans
- **Linux Wallpaper Engine** — wallpapers animados
- **Lossless Scaling** — upscaling de jogos

### Rede
- **ZeroTier** — VPN mesh
- **NetworkManager** — gerenciamento de rede
- **Logmein Hamachi** — VPN alternativa
- **WoMic** — microfone via rede

### Sistema
- **Btrfs Assistant** + **Snapper** — gerenciamento/snapshots btrfs
- **MergerFS** — união de discos
- **Podman** + **Distrobox** — containers
- **Profile Sync Daemon** — sincroniza perfis de browser na RAM
- **Resources** — monitor do sistema
- **Btop** + **Fastfetch** — monitoramento terminal

### Periféricos
- **OpenRazer** + **Polychromatic** + **RazerGenie** — periféricos Razer
- **Bluez** — Bluetooth

## ⚙️ Configurações incluídas

| Arquivo | Local | Descrição |
|---|---|---|
| `hypr/` | `~/.config/hypr/` | Config do Hyprland + keybinds |
| `noctalia/` | `~/.config/noctalia/` | Shell, cores, plugins |
| `fish/` | `~/.config/fish/` | Shell Fish |
| `alacritty/` | `~/.config/alacritty/` | Terminal + cores Material You |
| `niri/` | `~/.config/niri/` | Config do Niri (backup) |
| `boot/` | `/boot/` | rEFInd com hibernação |
| `wallpapers/` | `~/Imagens/` | Wallpapers pessoais |

## 🚀 Instalação em um novo sistema

### 1. Instala o CachyOS com btrfs

### 2. Clona o repositório
```bash
git clone https://github.com/gabrielm3234/dotfiles ~/dotfiles
cd ~/dotfiles
```

### 3. Roda o script de instalação
```bash
chmod +x install.sh
./install.sh
```

O script faz automaticamente:
- Instala todos os pacotes (pacman + AUR)
- Aplica os dotfiles via GNU Stow (symlinks)
- Configura swap file de 16GB para hibernação
- Configura rEFInd com parâmetros de hibernação
- Regenera o initramfs
- Ativa todos os serviços necessários
- Configura o firewall (UFW)
- Copia os wallpapers

## 🌙 Hibernação

Configurada via swap file no btrfs em `/swap/swapfile` (16GB).

Parâmetros no rEFInd: `resume=UUID=... resume_offset=...`

> ⚠️ O UUID e offset são gerados automaticamente pelo install.sh para o novo sistema.

## 🔒 Portas abertas no firewall

| Porta | Serviço |
|---|---|
| `9993/udp` | ZeroTier |
| `47984-48010` | Sunshine (streaming) |
| `47990/tcp` | Sunshine (painel web) |
| `1212/tcp+udp` | Servidor LAN |

## ⌨️ Keybinds principais (Hyprland)

| Tecla | Ação |
|---|---|
| `Super + Enter` | Terminal (Alacritty) |
| `Super + Ctrl + Enter` | Launcher de apps |
| `Super + B` | Firefox |
| `Super + E` | Nautilus |
| `Super + Q` | Fecha janela |
| `Super + F` | Fullscreen |
| `Super + T` | Toggle flutuante |
| `Super + 1-9` | Workspaces |
| `Super + Tab` | Workspace anterior |
| `Ctrl + Shift + 1` | Screenshot região |
| `Ctrl + Shift + 2` | Screenshot tela |
| `Super + Alt + L` | Bloquear tela |
| `Super + Shift + Q` | Menu sessão |
