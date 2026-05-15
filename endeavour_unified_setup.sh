#!/bin/bash

#######################################
# Script Unifié EndeavourOS - Configuration Complète 2026
# Version: 3.1.0 (Mai 2026)
# Regroupe : Post-installation, Gaming, Terminal, Fastfetch, BTRFS
# Nouveautés : Compatibilité multi-machines, Optimisations avancées, AI tools, Wayland
#######################################

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
ORANGE='\033[38;5;208m'
NC='\033[0m' # No Color

# Variables globales
SCRIPT_VERSION="3.1.0"
LOG_FILE="/tmp/endeavour_unified_setup_$(date +%Y%m%d).log"
CONFIG_FILE="$HOME/.endeavour_setup_config"
DETECTED_BTRFS_DISKS=()
MOUNT_POINTS=()
SYSTEM_INFO=()
IS_WAYLAND=false
SKIP_NVIDIA=false
SKIP_GAMING=false
SKIP_AI=false
SKIP_AUR=false

#######################################
# FONCTIONS UTILITAIRES MODERNISÉES
#######################################

print_header() {
    clear
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║              ENDEAVOUR OS - SETUP UNIFIÉ 2026 (v$SCRIPT_VERSION)              ║${NC}"
    echo -e "${PURPLE}║    Post-install • Gaming • AI Tools • Wayland • BTRFS • Multi-machines     ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${CYAN}➤${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1" >> "$LOG_FILE"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESS] $1" >> "$LOG_FILE"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [WARNING] $1" >> "$LOG_FILE"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_FILE"
}

check_error() {
    if [ $? -ne 0 ]; then
        print_error "$1"
        exit 1
    fi
}

check_dependencies() {
    local missing_deps=()

    for dep in git curl wget sudo; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Dépendances manquantes: ${missing_deps[*]}"
        print_step "Installez-les avec: sudo pacman -S ${missing_deps[*]}"
        exit 1
    fi
}

detect_wayland() {
    if [[ -n "$WAYLAND_DISPLAY" || "$XDG_SESSION_TYPE" == "wayland" ]]; then
        IS_WAYLAND=true
        print_step "Session Wayland détectée"
    else
        IS_WAYLAND=false
        print_step "Session X11 détectée"
    fi
}

get_system_info() {
    SYSTEM_INFO=(
        "Host: $(hostname)"
        "OS: $(grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2)"
        "Kernel: $(uname -r)"
        "CPU: $(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)"
        "GPU: $(lspci -k | grep -A 2 -E "(VGA|3D)" | grep "Subsystem" | cut -d ':' -f 2 | xargs)"
        "Memory: $(free -h | awk '/Mem/{print $3 "/" $2}')"
        "Disk: $(df -h / | awk '/\//{print $3 "/" $2}')"
        "Shell: $SHELL"
        "Wayland: $IS_WAYLAND"
    )
}

load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
        print_step "Configuration chargée depuis $CONFIG_FILE"
    else
        print_step "Aucun fichier de configuration trouvé, utilisation des valeurs par défaut"
    fi
}

#######################################
# DÉTECTION AUTOMATIQUE DES DISQUES BTRFS
#######################################

detect_btrfs_disks() {
    print_step "Détection des disques BTRFS..."

    # Méthode fiable sans jq
    while IFS= read -r line; do
        if [[ "$line" =~ btrfs ]]; then
            device=$(echo "$line" | awk '{print $1}')
            if [[ -b "$device" && ! " ${DETECTED_BTRFS_DISKS[@]} " =~ " $device " ]]; then
                DETECTED_BTRFS_DISKS+=("$device")
                print_step "Disque BTRFS détecté: $device"
            fi
        fi
    done < <(lsblk -f -o NAME,FSTYPE | grep btrfs | awk '{print "/dev/" $1 " " $2}')

    if [[ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]]; then
        print_warning "Aucun disque BTRFS détecté"
    fi
}

show_detected_disks() {
    echo ""
    print_step "Disques BTRFS détectés:"
    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        size=$(lsblk -bno SIZE "$disk" | awk '{print $1/1024/1024/1024 " GiB"}' | xargs)
        model=$(lsblk -dno MODEL "$disk" | xargs)
        uuid=$(sudo blkid -o value -s UUID "$disk" 2>/dev/null)
        echo -e "${CYAN}$((i+1)).${NC} $disk - $size - $model ${PURPLE}(UUID: $uuid)${NC}"
    done
}

auto_configure_btrfs_disks() {
    print_step "Configuration automatique des disques BTRFS..."

    if [[ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]]; then
        detect_btrfs_disks
    fi

    for disk in "${DETECTED_BTRFS_DISKS[@]}"; do
        mount_name=$(basename "$disk" | sed 's/[^a-zA-Z0-9]//g' | tr '[:upper:]' '[:lower:]')

        # Détection intelligente du type de disque
        if [[ "$disk" == *"nvme"* ]]; then
            mount_name="nvme_${mount_name}"
        elif [[ "$(lsblk -bno SIZE "$disk" | awk '{print $1}')" -gt 2000000000000 ]]; then
            mount_name="data_${mount_name}"
        else
            mount_name="disk_${mount_name}"
        fi

        configure_btrfs_disk "$disk" "$mount_name"
    done

    # Création des liens symboliques
    create_symlinks
}

configure_btrfs_disk() {
    local disk="$1"
    local mount_name="$2"
    local mount_point="/mnt/$mount_name"

    print_step "Configuration de $disk -> $mount_point..."

    # Obtenir l'UUID
    local uuid=$(sudo blkid -o value -s UUID "$disk" 2>/dev/null)
    if [[ -z "$uuid" ]]; then
        print_error "Impossible d'obtenir l'UUID de $disk"
        return 1
    fi

    print_step "UUID: $uuid"

    # Créer le point de montage
    sudo mkdir -p "$mount_point" 2>&1 | tee -a "$LOG_FILE"

    # Démonter si déjà monté
    if mountpoint -q "$mount_point" 2>/dev/null; then
        print_step "Démontage de $mount_point..."
        sudo umount "$mount_point" 2>&1 | tee -a "$LOG_FILE"
    fi

    # Supprimer l'ancienne entrée dans fstab
    sudo sed -i "\|$mount_point|d" /etc/fstab 2>&1 | tee -a "$LOG_FILE"

    # Ajouter la nouvelle entrée dans fstab (options modernes)
    print_step "Ajout dans /etc/fstab..."
    echo "UUID=$uuid $mount_point btrfs defaults,noatime,space_cache=v2,compress=zstd:3,ssd,discard=async 0 2" | sudo tee -a /etc/fstab 2>&1 | tee -a "$LOG_FILE"

    # Monter le disque
    print_step "Montage de $mount_point..."
    sudo mount "$mount_point" 2>&1 | tee -a "$LOG_FILE"
    check_error "Échec du montage de $mount_point"

    # Configurer les permissions
    print_step "Configuration des permissions..."
    sudo chmod 755 "$mount_point" 2>&1 | tee -a "$LOG_FILE"
    sudo chown "$USER:users" "$mount_point" 2>&1 | tee -a "$LOG_FILE"

    # Optimisation initiale
    print_step "Optimisation initiale du filesystem..."
    sudo btrfs filesystem defragment -r -v -czstd "$mount_point" 2>&1 | tee -a "$LOG_FILE" &
    sudo btrfs balance start -dusage=50 -musage=50 "$mount_point" 2>&1 | tee -a "$LOG_FILE" &

    MOUNT_POINTS+=("$mount_point")
    print_success "Disque $disk configuré avec succès"
}

create_symlinks() {
    print_step "Création des liens symboliques..."

    # Créer le répertoire de liens s'il n'existe pas
    mkdir -p "$HOME/Storage"

    for mount_point in "${MOUNT_POINTS[@]}"; do
        local link_name=$(basename "$mount_point")

        # Déterminer le type de lien
        if [[ "$link_name" == *"nvme"* ]]; then
            link_name="SSD_${link_name#*_}"
        elif [[ "$link_name" == *"data"* ]]; then
            link_name="Data_${link_name#*_}"
        fi

        # Créer le lien symbolique
        if [[ ! -L "$HOME/Storage/$link_name" ]]; then
            ln -sf "$mount_point" "$HOME/Storage/$link_name" 2>&1 | tee -a "$LOG_FILE"
            print_step "Lien créé: ~/Storage/$link_name -> $mount_point"
        fi
    done
}

#######################################
# POST-INSTALLATION SYSTÈME 2026
#######################################

update_system() {
    print_step "Mise à jour complète du système (Kernel 6.8+)..."

    # Forcer la synchronisation des miroirs
    sudo pacman -Syy --noconfirm 2>&1 | tee -a "$LOG_FILE"

    # Mise à jour complète
    sudo pacman -Syu --noconfirm 2>&1 | tee -a "$LOG_FILE"
    check_error "Échec de la mise à jour du système"

    # Installation du dernier kernel LTS
    sudo pacman -S --noconfirm linux-lts linux-lts-headers 2>&1 | tee -a "$LOG_FILE"

    print_success "Système mis à jour avec le kernel 6.8+"
}

install_nvidia_drivers() {
    if [[ "$SKIP_NVIDIA" == true ]]; then
        print_step "Installation des pilotes NVIDIA ignorée (configuré pour sauter)"
        return
    fi

    if lspci | grep -i nvidia > /dev/null; then
        print_step "Carte NVIDIA détectée. Installation des pilotes 2026..."

        # Pilotes NVIDIA modernes
        sudo pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings nvidia-prime 2>&1 | tee -a "$LOG_FILE"

        # Pour Wayland
        if [[ "$IS_WAYLAND" == true ]]; then
            sudo pacman -S --noconfirm nvidia-egl-wayland 2>&1 | tee -a "$LOG_FILE"
            echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf 2>&1 | tee -a "$LOG_FILE"
        fi

        # Configuration pour le gaming
        sudo nvidia-xconfig --cool-bits=28 --allow-empty-initial-configuration 2>&1 | tee -a "$LOG_FILE"

        print_success "Pilotes NVIDIA 2026 installés"
    else
        print_step "Aucune carte NVIDIA détectée"
    fi
}

install_essential_packages() {
    print_step "Installation des paquets essentiels 2026..."

    ESSENTIAL_PACKAGES=(
        # Développement
        "base-devel" "git" "git-delta" "lazygit" "vim" "neovim" "wget" "curl" "htop" "btop" "tree"
        "unzip" "zip" "p7zip" "rsync" "openssh" "bash-completion" "zsh-completions" "fzf"
        "ripgrep" "fd" "jq" "yq" "yazi" "eza" "bat" "sd" "just" "dust" "duf" "procs"

        # Multimédia
        "ffmpeg" "gst-plugins-base" "gst-plugins-good" "gst-plugins-bad" "gst-plugins-ugly"
        "gst-libav" "libdvdcss" "x264" "x265" "lame" "pipewire" "pipewire-pulse" "pipewire-alsa"
        "wireplumber" "pavucontrol" "playerctl" "mpv" "yt-dlp"

        # Polices
        "ttf-liberation" "ttf-dejavu" "ttf-roboto" "noto-fonts" "noto-fonts-emoji" "noto-fonts-cjk"
        "ttf-firacode-nerd" "ttf-jetbrains-mono-nerd" "ttf-meslo-nerd" "ttf-ubuntu-font-family"

        # Applications
        "firefox" "thunderbird" "libreoffice-fresh" "gimp" "inkscape" "blender" "kdenlive"
        "obs-studio" "vlc" "gparted" "timeshift" "gufw" "ark" "kitty" "alacritty" "tmux"

        # Outils système
        "flatpak" "snapd" "appimagelauncher" "fwupd" "tlp" "tlp-rdw" "powertop" "thermald"
        "earlyoom" "preload" "reflector" "rsync" "borg" "restic" "age" "sops"

        # Virtualisation
        "qemu" "virt-manager" "libvirt" "edk2-ovmf" "dnsmasq" "ebtables" "iptables-nft"

        # AI/ML
        "python-pytorch" "python-tensorflow" "python-jupyterlab" "ollama" "stable-diffusion"
    )

    # Installation par lots pour plus de rapidité
    sudo pacman -S --needed --noconfirm "${ESSENTIAL_PACKAGES[@]}" 2>&1 | tee -a "$LOG_FILE"

    # Configuration de PipeWire
    sudo systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>&1 | tee -a "$LOG_FILE"

    print_success "Paquets essentiels 2026 installés"
}

install_yay() {
    if ! command -v yay &> /dev/null; then
        print_step "Installation de yay (AUR helper 2026)..."

        # Installation avec makepkg optimisé
        cd /tmp || exit
        git clone https://aur.archlinux.org/yay-bin.git 2>&1 | tee -a "$LOG_FILE"
        cd yay-bin || exit
        makepkg -si --noconfirm --needed 2>&1 | tee -a "$LOG_FILE"
        cd ~ || exit

        # Configuration de yay
        yay -Y --gendb 2>&1 | tee -a "$LOG_FILE"
        yay -Y --devel --save 2>&1 | tee -a "$LOG_FILE"

        print_success "yay installé et configuré"
    else
        print_step "yay déjà installé"
        yay -Syu --devel --noconfirm 2>&1 | tee -a "$LOG_FILE"
    fi
}

install_aur_apps() {
    if [[ "$SKIP_AUR" == true ]]; then
        print_step "Installation des applications AUR ignorée (configuré pour sauter)"
        return
    fi

    print_step "Installation des applications AUR 2026..."

    AUR_PACKAGES=(
        "visual-studio-code-bin"
        "google-chrome"
        "spotify"
        "discord"
        "teams"
        "zoom"
        "postman-bin"
        "insomnia"
        "bitwarden"
        "onlyoffice-bin"
        "protonvpn"
        "mullvad-vpn"
        "vscodium-bin"
        "jetbrains-toolbox"
        "docker-desktop"
        "podman-desktop"
        "distrobox"
        "waydroid"
        "anbox"
        "heroic-games-launcher-bin"
        "bottles"
        "protonup-qt"
        "mangohud"
        "gamemode"
        "wine-staging"
        "winetricks"
        "dxvk-bin"
        "vkd3d-proton-bin"
        "latte-dock-git"
        "plasma5-applets-eventcalendar"
        "kvantum"
        "ttf-ms-win11-auto"
        "ttf-apple-emoji"
        "nerd-fonts-complete"
        "oh-my-zsh-git"
        "powerlevel10k"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "zsh-history-substring-search"
        "fastfetch-git"
        "neofetch"
        "pfetch"
        "cava"
        "bpytop"
        "glances"
        "gotop"
        "ttf-twemoji"
        "ttf-joypixels"
        "ttf-symbola"
        "ttf-nerd-fonts-symbols"
        "ttf-nerd-fonts-symbols-mono"
        "ttf-nerd-fonts-symbols-2048-em"
        "ttf-nerd-fonts-symbols-1000-em"
        "ttf-material-design-icons"
        "ttf-font-awesome"
        "ttf-weather-icons"
        "ttf-devicons"
        "ttf-octicons"
        "ttf-codicons"
        "ttf-powerline"
        "ttf-powerline-symbols"
        "ttf-nerd-fonts-fira-code"
        "ttf-nerd-fonts-jetbrains-mono"
        "ttf-nerd-fonts-meslo"
        "ttf-nerd-fonts-roboto-mono"
        "ttf-nerd-fonts-source-code-pro"
        "ttf-nerd-fonts-ubuntu-mono"
        "ttf-nerd-fonts-hack"
        "ttf-nerd-fonts-cascadia-code"
        "ttf-nerd-fonts-iosevka"
        "ttf-nerd-fonts-ubuntu"
        "ttf-nerd-fonts-droid-sans-mono"
        "ttf-nerd-fonts-inconsolata"
        "ttf-nerd-fonts-mononoki"
        "ttf-nerd-fonts-profont"
        "ttf-nerd-fonts-share-tech-mono"
        "ttf-nerd-fonts-terminus"
        "ttf-nerd-fonts-3270"
        "ttf-nerd-fonts-anonymice"
        "ttf-nerd-fonts-arimo"
        "ttf-nerd-fonts-aurulent-sans-mono"
        "ttf-nerd-fonts-bigblue-terminal"
        "ttf-nerd-fonts-bitstream-vera-sans-mono"
        "ttf-nerd-fonts-cousine"
        "ttf-nerd-fonts-daddytime-mono"
        "ttf-nerd-fonts-dejavu-sans-mono"
        "ttf-nerd-fonts-fantasque-sans-mono"
        "ttf-nerd-fonts-fira-mono"
        "ttf-nerd-fonts-go-mono"
        "ttf-nerd-fonts-gohu"
        "ttf-nerd-fonts-hasklig"
        "ttf-nerd-fonts-heavy-data-nerd-font"
        "ttf-nerd-fonts-lekton"
        "ttf-nerd-fonts-liberation-mono"
        "ttf-nerd-fonts-mplus"
        "ttf-nerd-fonts-proggy-clean"
        "ttf-nerd-fonts-roboto"
        "ttf-nerd-fonts-sauce-code-pro"
        "ttf-nerd-fonts-space-mono"
        "ttf-nerd-fonts-tinos"
        "ttf-nerd-fonts-ubuntu-nerd"
        "ttf-nerd-fonts-victor-mono"
    )

    # Installation par lots avec yay
    yay -S --needed --noconfirm "${AUR_PACKAGES[@]}" 2>&1 | tee -a "$LOG_FILE"

    print_success "Applications AUR 2026 installées"
}

#######################################
# CONFIGURATION TERMINAL 2026
#######################################

install_terminal_setup() {
    print_step "Installation et configuration du terminal 2026..."

    # Installation des paquets
    sudo pacman -S --noconfirm kitty zsh zsh-completions starship zoxide fzf exa bat ripgrep fd 2>&1 | tee -a "$LOG_FILE"

    # Configuration de zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>&1 | tee -a "$LOG_FILE"
    fi

    # Configuration de starship
    if [[ ! -f "$HOME/.config/starship.toml" ]]; then
        mkdir -p "$HOME/.config"
        curl -sS https://starship.rs/install.sh | sh -s -- --yes 2>&1 | tee -a "$LOG_FILE"
        cat > "$HOME/.config/starship.toml" << 'EOF'
# Configuration Starship 2026
add_newline = true
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_state\
$git_status\
$cmd_duration\
$line_break\
$character"""

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
vicmd_symbol = "[❮](bold yellow)"

[directory]
truncation_length = 3
truncate_to_repo = false
style = "bold blue"

[git_branch]
symbol = " "
style = "bold purple"

[git_status]
style = "bold green"
format = "([$all_status$ahead_behind]($style) )"

[cmd_duration]
style = "bold yellow"
EOF
    fi

    # Configuration de zoxide
    if ! grep -q "zoxide" "$HOME/.zshrc"; then
        echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
    fi

    print_success "Terminal 2026 configuré"
}

configure_kitty() {
    print_step "Configuration avancée de Kitty 2026..."

    mkdir -p "$HOME/.config/kitty"

    # Configuration moderne avec support Wayland
    cat > "$HOME/.config/kitty/kitty.conf" << 'EOF'
# Configuration Kitty 2026 - Thème Cyberpunk

# Fontes
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        12.0

# Fenêtre
remember_window_size  no
initial_window_width  120c
initial_window_height 34c
window_padding_width  8
window_border_width   0.5
draw_minimal_borders  yes
hide_window_decorations yes
wayland_titlebar_color system

# Couleurs (Thème Cyberpunk)
foreground #e0e0e0
background #0a0a12
cursor #ff00aa
cursor_text_color #0a0a12
selection_foreground #0a0a12
selection_background #ff00aa

# Couleurs normales
color0  #121212
color1  #ff0055
color2  #00ff9f
color3  #ff9f00
color4  #00aaff
color5  #aa00ff
color6  #00ffff
color7  #e0e0e0

# Couleurs brillantes
color8  #4a4a4a
color9  #ff55aa
color10 #55ffaa
color11 #ffaa55
color12 #55aaff
color13 #ff55ff
color14 #55ffff
color15 #ffffff

# Transparence
background_opacity 0.9
dynamic_background_opacity yes

# Raccourcis
map ctrl+shift+t new_tab
map ctrl+shift+w close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left prev_tab
map ctrl+shift+enter new_window
map ctrl+shift+f toggle_fullscreen
map ctrl+shift+up scroll_line_up
map ctrl+shift+down scroll_line_down
map ctrl+shift+page_up scroll_page_up
map ctrl+shift+page_down scroll_page_down
map ctrl+shift+home scroll_home
map ctrl+shift+end scroll_end

# Onglets
tab_bar_edge top
tab_bar_style powerline
tab_powerline_style slanted
active_tab_foreground   #0a0a12
active_tab_background   #00aaff
inactive_tab_foreground #e0e0e0
inactive_tab_background #1a1a2e
tab_bar_background      #0a0a12

# Performance
repaint_delay 10
input_delay 3
sync_to_monitor yes

# Wayland
wayland_enable true
linux_display_server wayland
EOF

    # Configuration spécifique pour Wayland
    if [[ "$IS_WAYLAND" == true ]]; then
        echo "wayland_enable true" >> "$HOME/.config/kitty/kitty.conf"
        echo "linux_display_server wayland" >> "$HOME/.config/kitty/kitty.conf"
    fi

    print_success "Kitty 2026 configuré"
}

#######################################
# FASTFETCH 2026
#######################################

install_and_configure_fastfetch() {
    print_step "Installation et configuration de Fastfetch 2026..."

    # Installation
    if ! command -v fastfetch &> /dev/null; then
        sudo pacman -S --noconfirm fastfetch 2>&1 | tee -a "$LOG_FILE"
    fi

    # Configuration
    mkdir -p "$HOME/.config/fastfetch"

    cat > "$HOME/.config/fastfetch/config.jsonc" << 'EOF'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "file",
        "source": "/usr/share/fastfetch/logos/archlinux.png",
        "width": 30,
        "padding": {
            "top": 1,
            "left": 2
        }
    },
    "display": {
        "separator": " : ",
        "keyColor": "blue",
        "color": {
            "frame": "blue",
            "title": "blue"
        },
        "binaryPrefix": true,
        "sizeNdigits": 2,
        "sizeUnit": "iec",
        "noBuffer": false
    },
    "modules": [
        {
            "type": "title",
            "key": "System",
            "format": "╭───────────────────────────────────────────────────╮"
        },
        {
            "type": "os",
            "key": "│  OS"
        },
        {
            "type": "host",
            "key": "│  Host"
        },
        {
            "type": "kernel",
            "key": "│  Kernel"
        },
        {
            "type": "uptime",
            "key": "│  Uptime"
        },
        {
            "type": "packages",
            "key": "│  Packages",
            "format": "{1} (pacman), {2} (flatpak), {3} (snap)"
        },
        {
            "type": "shell",
            "key": "│  Shell"
        },
        {
            "type": "title",
            "key": "Hardware",
            "format": "├───────────────────────────────────────────────────┤"
        },
        {
            "type": "cpu",
            "key": "│  CPU"
        },
        {
            "type": "gpu",
            "key": "│  GPU"
        },
        {
            "type": "memory",
            "key": "│  Memory"
        },
        {
            "type": "disk",
            "key": "│  Disk",
            "format": "{1} ({2}%)"
        },
        {
            "type": "title",
            "key": "Network",
            "format": "├───────────────────────────────────────────────────┤"
        },
        {
            "type": "localip",
            "key": "│  Local IP"
        },
        {
            "type": "publicip",
            "key": "│  Public IP"
        },
        {
            "type": "wifi",
            "key": "│  WiFi"
        },
        {
            "type": "title",
            "key": "Session",
            "format": "├───────────────────────────────────────────────────┤"
        },
        {
            "type": "de",
            "key": "│  DE"
        },
        {
            "type": "wm",
            "key": "│  WM"
        },
        {
            "type": "wmtheme",
            "key": "│  WM Theme"
        },
        {
            "type": "theme",
            "key": "│  Theme"
        },
        {
            "type": "icons",
            "key": "│  Icons"
        },
        {
            "type": "font",
            "key": "│  Font"
        },
        {
            "type": "cursor",
            "key": "│  Cursor"
        },
        {
            "type": "terminal",
            "key": "│  Terminal"
        },
        {
            "type": "terminalfont",
            "key": "│  Terminal Font"
        },
        {
            "type": "title",
            "key": "Misc",
            "format": "├───────────────────────────────────────────────────┤"
        },
        {
            "type": "locale",
            "key": "│  Locale"
        },
        {
            "type": "break"
        },
        {
            "type": "colors",
            "key": "│  Colors",
            "paddingLeft": 3,
            "symbol": "circle"
        },
        {
            "type": "title",
            "format": "╰───────────────────────────────────────────────────╯"
        }
    ]
}
EOF

    # Ajouter fastfetch au .zshrc
    if ! grep -q "fastfetch" "$HOME/.zshrc"; then
        echo "fastfetch --load-config ~/.config/fastfetch/config.jsonc" >> "$HOME/.zshrc"
    fi

    print_success "Fastfetch 2026 configuré"
}

#######################################
# GAMING 2026
#######################################

install_gaming_tools() {
    if [[ "$SKIP_GAMING" == true ]]; then
        print_step "Installation des outils gaming ignorée (configuré pour sauter)"
        return
    fi

    print_step "Installation des outils gaming 2026..."

    # Outils gaming essentiels
    sudo pacman -S --noconfirm \
        mangohud \
        gamemode \
        goverlay \
        vkbasalt \
        lib32-mangohud \
        lib32-gamemode \
        lib32-vkbasalt \
        wine-staging \
        winetricks \
        dxvk \
        vkd3d \
        protontricks \
        protonup-qt \
        heroic-games-launcher-bin \
        bottles \
        lutris \
        steam \
        steam-native-runtime \
        gamemode \
        lib32-gamemode \
        lib32-vulkan-icd-loader \
        vulkan-icd-loader \
        vulkan-tools \
        vulkan-mesa-layers \
        lib32-vulkan-mesa-layers

    # Configuration de MangoHud
    mkdir -p "$HOME/.config/MangoHud"
    cat > "$HOME/.config/MangoHud/MangoHud.conf" << 'EOF'
# Configuration MangoHud 2026
legacy_layout=0
no_display=0
output_folder=mangohud_output
position=top-left
background_alpha=0.5
font_size=24
font_scale=1.0
round_corners=10
table_columns=15
gpu_stats
gpu_temp
gpu_core_clock
gpu_mem_clock
gpu_power
cpu_stats
cpu_temp
cpu_power
ram
vram
fps
frame_timing=1
frame_count=0
hud_no_margin
time
exec
io_read
io_write
gpu_name
cpu_name
vulkan_driver
arch
wine
resolution
media_player
version
EOF

    # Configuration de Gamemode
    sudo systemctl enable gamemoded
    sudo systemctl start gamemoded

    # Configuration de Steam
    if [[ ! -d "$HOME/.steam" ]]; then
        mkdir -p "$HOME/.steam/steam/steamapps/compatdata"
    fi

    # Configuration de Proton
    mkdir -p "$HOME/.steam/root/compatibilitytools.d"
    if [[ ! -d "$HOME/.steam/root/compatibilitytools.d/Proton-Exp" ]]; then
        print_step "Installation de Proton Experimental..."
        wget -qO- https://github.com/GloriousEggroll/proton-ge-custom/releases/latest/download/GE-Proton9-1.tar.gz | tar -xz -C "$HOME/.steam/root/compatibilitytools.d/"
    fi

    print_success "Outils gaming 2026 installés"
}

#######################################
# AI/ML TOOLS 2026
#######################################

install_ai_tools() {
    if [[ "$SKIP_AI" == true ]]; then
        print_step "Installation des outils AI/ML ignorée (configuré pour sauter)"
        return
    fi

    print_step "Installation des outils AI/ML 2026..."

    # Outils AI essentiels
    sudo pacman -S --noconfirm \
        python-pytorch \
        python-tensorflow \
        python-jupyterlab \
        python-scikit-learn \
        python-pandas \
        python-numpy \
        python-matplotlib \
        python-seaborn \
        python-opencv \
        python-transformers \
        python-diffusers \
        python-accelerate \
        python-safetensors \
        python-peft \
        python-bitsandbytes \
        ollama \
        stable-diffusion-webui \
        comfyui \
        automatic1111-sd-webui

    # Configuration de Ollama
    if ! command -v ollama &> /dev/null; then
        curl -fsSL https://ollama.com/install.sh | sh 2>&1 | tee -a "$LOG_FILE"
    fi

    # Téléchargement des modèles populaires
    print_step "Téléchargement des modèles AI populaires..."
    ollama pull llama3:latest 2>&1 | tee -a "$LOG_FILE" &
    ollama pull mistral:latest 2>&1 | tee -a "$LOG_FILE" &
    ollama pull phi3:latest 2>&1 | tee -a "$LOG_FILE" &

    # Configuration de Stable Diffusion
    if [[ ! -d "$HOME/stable-diffusion-webui" ]]; then
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git "$HOME/stable-diffusion-webui" 2>&1 | tee -a "$LOG_FILE"
        cd "$HOME/stable-diffusion-webui" || exit
        ./webui.sh --skip-torch-cuda-test --no-half-vae --xformers 2>&1 | tee -a "$LOG_FILE" &
    fi

    print_success "Outils AI/ML 2026 installés"
}

#######################################
# OPTIMISATIONS SYSTÈME 2026
#######################################

apply_system_optimizations() {
    print_step "Application des optimisations système 2026..."

    # Configuration de pacman
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 15/' /etc/pacman.conf
    sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
    sudo pacman -Sy --noconfirm 2>&1 | tee -a "$LOG_FILE"

    # Services essentiels
    sudo systemctl enable --now bluetooth NetworkManager ufw tlp thermald earlyoom preload 2>&1 | tee -a "$LOG_FILE"
    sudo ufw enable 2>&1 | tee -a "$LOG_FILE"

    # Optimisations du noyau
    echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.d/99-vfs.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'vm.dirty_ratio=10' | sudo tee -a /etc/sysctl.d/99-dirty.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'vm.dirty_background_ratio=5' | sudo tee -a /etc/sysctl.d/99-dirty.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'kernel.nmi_watchdog=0' | sudo tee -a /etc/sysctl.d/99-gaming.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'kernel.sched_autogroup_enabled=0' | sudo tee -a /etc/sysctl.d/99-gaming.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'vm.max_map_count=1048576' | sudo tee -a /etc/sysctl.d/99-gaming.conf 2>&1 | tee -a "$LOG_FILE"

    # Optimisations pour les SSD/NVMe
    echo 'ACTION=="add|change", KERNEL=="sd[a-z]|nvme[0-9]*", ATTR{queue/read_ahead_kb}="128"' | sudo tee /etc/udev/rules.d/99-ssd.rules 2>&1 | tee -a "$LOG_FILE"
    echo 'ACTION=="add|change", KERNEL=="sd[a-z]|nvme[0-9]*", ATTR{queue/scheduler}="none"' | sudo tee -a /etc/udev/rules.d/99-ssd.rules 2>&1 | tee -a "$LOG_FILE"

    # Optimisations pour le gaming
    echo 'options nvidia NVreg_EnableDeepColor=1' | sudo tee /etc/modprobe.d/nvidia.conf 2>&1 | tee -a "$LOG_FILE"
    echo 'options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"' | sudo tee -a /etc/modprobe.d/nvidia.conf 2>&1 | tee -a "$LOG_FILE"

    # Configuration de TLP
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=.*/CPU_SCALING_GOVERNOR_ON_AC=performance/' /etc/tlp.conf
    sudo sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=.*/CPU_SCALING_GOVERNOR_ON_BAT=powersave/' /etc/tlp.conf
    sudo sed -i 's/#CPU_ENERGY_PERF_POLICY_ON_AC=.*/CPU_ENERGY_PERF_POLICY_ON_AC=performance/' /etc/tlp.conf
    sudo sed -i 's/#CPU_ENERGY_PERF_POLICY_ON_BAT=.*/CPU_ENERGY_PERF_POLICY_ON_BAT=power/' /etc/tlp.conf

    # Configuration de earlyoom
    sudo sed -i 's|#EARLYOOM_ARGS=""|EARLYOOM_ARGS="-r 60 -m 10 -M 409600 --avoid '\''(^|/)(init|systemd|Xorg|sshd|gdm|sddm|lightdm|kwin|plasmashell|gnome-shell|gnome-session|gnome-settings-daemon|dbus-daemon|pipewire|wireplumber)'\''"|' /etc/default/earlyoom

    # Variables d'environnement
    cat >> "$HOME/.bashrc" << 'EOF'

# Optimisations système 2026
export WINE_CPU_TOPOLOGY=$(nproc):$(nproc)
export DXVK_HUD=fps,devinfo,version,gpu
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv_shader_cache"
export __GL_THREADED_OPTIMIZATIONS=1
export __GL_SYNC_TO_VBLANK=0
export __GL_MaxFramesAllowed=1
export MESA_GLTHREAD=true
export vblank_mode=0
export CLUTTER_PAINT=disable-clipped-redraws:disable-culling
export CLUTTER_VBLANK=none
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
export SDL_JOYSTICK_HIDAPI=0
export SDL_GAMECONTROLLERCONFIG_FILE="$HOME/.config/SDL_GameControllerDB/gamecontrollerdb.txt"
EOF

    # Configuration de la base de données des contrôleurs
    mkdir -p "$HOME/.config/SDL_GameControllerDB"
    curl -sSL https://raw.githubusercontent.com/gabomdq/SDL_GameControllerDB/master/gamecontrollerdb.txt -o "$HOME/.config/SDL_GameControllerDB/gamecontrollerdb.txt"

    # Configuration de Wayland
    if [[ "$IS_WAYLAND" == true ]]; then
        echo 'export QT_QPA_PLATFORM=wayland' >> "$HOME/.bashrc"
        echo 'export GDK_BACKEND=wayland' >> "$HOME/.bashrc"
        echo 'export SDL_VIDEODRIVER=wayland' >> "$HOME/.bashrc"
        echo 'export CLUTTER_BACKEND=wayland' >> "$HOME/.bashrc"
        echo 'export MOZ_ENABLE_WAYLAND=1' >> "$HOME/.bashrc"
        echo 'export XDG_SESSION_TYPE=wayland' >> "$HOME/.bashrc"
        echo 'export XDG_CURRENT_DESKTOP=sway' >> "$HOME/.bashrc"
    fi

    # Recharger les paramètres sysctl
    sudo sysctl --system 2>&1 | tee -a "$LOG_FILE"

    print_success "Optimisations système 2026 appliquées"
}

#######################################
# NETTOYAGE SYSTÈME 2026
#######################################

cleanup_system() {
    print_step "Nettoyage complet du système 2026..."

    # Nettoyage des paquets orphelins
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>&1 | tee -a "$LOG_FILE" || true

    # Nettoyage du cache pacman
    sudo pacman -Scc --noconfirm 2>&1 | tee -a "$LOG_FILE"

    # Nettoyage des anciens kernels
    sudo pacman -R $(pacman -Q | grep "^linux[0-9]" | grep -v "$(uname -r | cut -d '-' -f 1)" | awk '{print $1}') --noconfirm 2>&1 | tee -a "$LOG_FILE" || true

    # Nettoyage yay si disponible
    if command -v yay &> /dev/null; then
        yay -Ycc --noconfirm 2>&1 | tee -a "$LOG_FILE"
        yay -Sc --noconfirm 2>&1 | tee -a "$LOG_FILE"
    fi

    # Nettoyage des fichiers temporaires
    sudo rm -rf /tmp/* 2>&1 | tee -a "$LOG_FILE"
    rm -rf "$HOME/.cache/*" 2>&1 | tee -a "$LOG_FILE"
    rm -rf "$HOME/.thumbnails/*" 2>&1 | tee -a "$LOG_FILE"
    rm -rf "$HOME/.local/share/Trash/*" 2>&1 | tee -a "$LOG_FILE"

    # Nettoyage des journaux système
    sudo journalctl --vacuum-time=7d 2>&1 | tee -a "$LOG_FILE"
    sudo journalctl --vacuum-size=100M 2>&1 | tee -a "$LOG_FILE"

    # Optimisation des bases de données
    sudo pacman-optimize 2>&1 | tee -a "$LOG_FILE"

    print_success "Système nettoyé et optimisé"
}

#######################################
# AFFICHAGE DU STATUT FINAL
#######################################

show_final_status() {
    print_header
    echo ""
    print_success "✨ CONFIGURATION COMPLÈTE TERMINÉE ✨"
    echo ""
    print_step "Informations système:"
    echo ""

    for info in "${SYSTEM_INFO[@]}"; do
        echo -e "  ${CYAN}•${NC} $info"
    done

    echo ""
    print_step "Montages BTRFS:"
    if [[ ${#MOUNT_POINTS[@]} -gt 0 ]]; then
        for mount_point in "${MOUNT_POINTS[@]}"; do
            echo -e "  ${CYAN}•${NC} $mount_point"
        done
    else
        echo -e "  ${YELLOW}Aucun montage BTRFS détecté${NC}"
    fi

    echo ""
    print_step "Liens symboliques créés:"
    if [[ -d "$HOME/Storage" ]]; then
        ls -la "$HOME/Storage" | grep -E "^l" | awk '{print "  • " $9 " -> " $11}' | while read -r line; do
            echo -e "${CYAN}$line${NC}"
        done
    else
        echo -e "  ${YELLOW}Aucun lien symbolique créé${NC}"
    fi

    echo ""
    print_warning "Actions recommandées après le redémarrage :"
    echo -e "  ${CYAN}1.${NC} Ouvrir Kitty comme terminal par défaut"
    echo -e "  ${CYAN}2.${NC} Lancer 'starship preset pastel-powerline -o ~/.config/starship.toml' pour personnaliser"
    echo -e "  ${CYAN}3.${NC} Configurer Steam avec : mangohud gamemoderun %command%"
    echo -e "  ${CYAN}4.${NC} Installer Proton-GE avec ProtonUp-Qt"
    echo -e "  ${CYAN}5.${NC} Lancer 'ollama pull llama3' pour télécharger des modèles AI"
    echo -e "  ${CYAN}6.${NC} Configurer votre environnement de bureau (KDE/GNOME/Sway)"

    echo ""
    print_step "Fichiers de configuration créés/modifiés :"
    echo -e "  ${CYAN}•${NC} ~/.config/kitty/kitty.conf"
    echo -e "  ${CYAN}•${NC} ~/.config/fastfetch/config.jsonc"
    echo -e "  ${CYAN}•${NC} ~/.config/MangoHud/MangoHud.conf"
    echo -e "  ${CYAN}•${NC} ~/.config/starship.toml"
    echo -e "  ${CYAN}•${NC} ~/.zshrc"

    echo ""
    print_step "Log complet disponible : ${CYAN}$LOG_FILE${NC}"
    echo ""
}

#######################################
# INSTALLATIONS GROUPÉES 2026
#######################################

full_installation() {
    print_step "🚀 INSTALLATION COMPLÈTE 2026 DÉMARRÉE"
    print_step "Cette installation peut prendre 45-90 minutes selon votre connexion..."
    echo ""

    # Initialisation
    get_system_info
    detect_wayland
    load_config

    # Phase 1 : Système de base
    print_step "Phase 1/6 : Système de base..."
    update_system
    install_nvidia_drivers
    install_essential_packages
    install_yay
    install_aur_apps

    # Phase 2 : Gaming
    print_step "Phase 2/6 : Outils gaming..."
    install_gaming_tools

    # Phase 3 : AI Tools
    print_step "Phase 3/6 : Outils AI/ML..."
    install_ai_tools

    # Phase 4 : Terminal
    print_step "Phase 4/6 : Configuration terminal..."
    install_terminal_setup
    configure_kitty

    # Phase 5 : Fastfetch
    print_step "Phase 5/6 : Fastfetch..."
    install_and_configure_fastfetch

    # Phase 6 : Disques et optimisations
    print_step "Phase 6/6 : Disques BTRFS et optimisations..."
    detect_btrfs_disks
    auto_configure_btrfs_disks
    apply_system_optimizations
    cleanup_system

    show_final_status

    echo ""
    print_success "🎉 INSTALLATION COMPLÈTE 2026 TERMINÉE !"
    ask_for_reboot
}

gaming_setup() {
    print_step "🎮 SETUP GAMING 2026 DÉMARRÉ"

    get_system_info
    detect_wayland
    load_config

    update_system
    install_nvidia_drivers
    install_gaming_tools
    apply_system_optimizations

    echo ""
    print_success "🎮 Setup gaming 2026 terminé !"
    echo ""
    print_step "Pour utiliser MangoHud et GameMode avec Steam :"
    echo -e "${CYAN}• Clic droit sur un jeu > Propriétés > Options de lancement${NC}"
    echo -e "${CYAN}• Ajouter : mangohud gamemoderun %command%${NC}"
    echo -e "${CYAN}• Pour les jeux Vulkan : vkbasalt %command%${NC}"

    ask_for_reboot
}

terminal_setup() {
    print_step "💻 SETUP TERMINAL 2026 DÉMARRÉ"

    get_system_info
    detect_wayland
    load_config

    install_terminal_setup
    configure_kitty
    install_and_configure_fastfetch

    echo ""
    print_success "💻 Setup terminal 2026 terminé !"
    echo ""
    print_step "Pour utiliser la nouvelle configuration :"
    echo -e "${CYAN}• Fermez ce terminal et ouvrez Kitty${NC}"
    echo -e "${CYAN}• Lancez 'starship preset pastel-powerline -o ~/.config/starship.toml' pour personnaliser${NC}"
    echo -e "${CYAN}• Exécutez 'exec zsh' pour recharger votre shell${NC}"

    ask_for_reboot
}

ai_setup() {
    print_step "🤖 SETUP AI/ML 2026 DÉMARRÉ"

    get_system_info
    load_config
    update_system
    install_ai_tools

    echo ""
    print_success "🤖 Setup AI/ML 2026 terminé !"
    echo ""
    print_step "Pour commencer avec l'AI :"
    echo -e "${CYAN}• Lancer 'ollama pull llama3' pour télécharger un modèle${NC}"
    echo -e "${CYAN}• Exécuter 'ollama run llama3' pour discuter avec le modèle${NC}"
    echo -e "${CYAN}• Pour Stable Diffusion : cd ~/stable-diffusion-webui && ./webui.sh${NC}"
    echo -e "${CYAN}• Pour ComfyUI : cd ~/ComfyUI && python main.py${NC}"

    ask_for_reboot
}

ask_for_reboot() {
    echo ""
    read -p "Voulez-vous redémarrer maintenant pour appliquer tous les changements ? (o/n): " reboot_choice

    if [[ $reboot_choice == "o" || $reboot_choice == "O" ]]; then
        print_step "Redémarrage en cours..."
        sudo reboot
    else
        print_warning "N'oubliez pas de redémarrer plus tard pour finaliser la configuration."
    fi
}

configure_skips() {
    print_step "Configuration des options de compatibilité multi-machines"

    echo "Cette configuration permet de sauter certaines installations selon votre machine."
    echo "Utile pour les machines sans GPU NVIDIA, sans besoin de gaming, etc."
    echo ""

    read -p "Sauter l'installation des pilotes NVIDIA ? (o/n) [n]: " skip_nvidia
    SKIP_NVIDIA=$([[ $skip_nvidia == "o" || $skip_nvidia == "O" ]] && echo true || echo false)

    read -p "Sauter l'installation des outils gaming ? (o/n) [n]: " skip_gaming
    SKIP_GAMING=$([[ $skip_gaming == "o" || $skip_gaming == "O" ]] && echo true || echo false)

    read -p "Sauter l'installation des outils AI/ML ? (o/n) [n]: " skip_ai
    SKIP_AI=$([[ $skip_ai == "o" || $skip_ai == "O" ]] && echo true || echo false)

    read -p "Sauter l'installation des applications AUR ? (o/n) [n]: " skip_aur
    SKIP_AUR=$([[ $skip_aur == "o" || $skip_aur == "O" ]] && echo true || echo false)

    # Sauvegarder la config
    cat > "$CONFIG_FILE" << EOF
# Configuration EndeavourOS Setup - Générée le $(date)
SKIP_NVIDIA=$SKIP_NVIDIA
SKIP_GAMING=$SKIP_GAMING
SKIP_AI=$SKIP_AI
SKIP_AUR=$SKIP_AUR
EOF

    print_success "Configuration sauvegardée dans $CONFIG_FILE"
}

#######################################
# MENU DE CONFIGURATION BTRFS AVANCÉ
#######################################

btrfs_menu() {
    while true; do
        print_header
        echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║         MENU CONFIGURATION BTRFS AVANCÉE         ║${NC}"
        echo -e "${CYAN}╠══════════════════════════════════════════════════╣${NC}"
        echo -e "${CYAN}║  1. Détecter les disques BTRFS                   ║${NC}"
        echo -e "${CYAN}║  2. Configurer automatiquement les disques      ║${NC}"
        echo -e "${CYAN}║  3. Configurer manuellement les disques         ║${NC}"
        echo -e "${CYAN}║  4. Voir le statut des montages                 ║${NC}"
        echo -e "${CYAN}║  5. Optimiser les filesystems BTRFS             ║${NC}"
        echo -e "${CYAN}║  6. Créer des liens symboliques                 ║${NC}"
        echo -e "${CYAN}║  7. Retour au menu principal                    ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
        echo ""
        read -p "Choisissez une option (1-7): " choice

        case $choice in
            1)
                detect_btrfs_disks
                show_detected_disks
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            2)
                auto_configure_btrfs_disks
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            3)
                detect_btrfs_disks
                manual_btrfs_configuration
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            4)
                show_btrfs_status
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            5)
                optimize_btrfs_filesystems
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            6)
                create_symlinks
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            7)
                return
                ;;
            *)
                print_error "Option invalide ! Veuillez choisir entre 1 et 7."
                sleep 2
                ;;
        esac
    done
}

manual_btrfs_configuration() {
    detect_btrfs_disks
    show_detected_disks

    if [[ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]]; then
        print_warning "Aucun disque BTRFS détecté"
        return
    fi

    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        echo ""
        echo -e "${CYAN}Configuration de $disk${NC}"
        read -p "Nom du point de montage (ex: nas, games, data, ssd): " mount_name

        if [[ -n "$mount_name" ]]; then
            configure_btrfs_disk "$disk" "$mount_name"
        else
            print_warning "Configuration de $disk ignorée"
        fi
    done
}

show_btrfs_status() {
    echo ""
    print_step "Statut des montages BTRFS:"
    echo ""

    # Montages actifs
    echo -e "${CYAN}Montages actifs:${NC}"
    mount | grep btrfs || echo "Aucun filesystem BTRFS monté"

    echo ""
    echo -e "${CYAN}Utilisation des disques:${NC}"
    for mount_point in "${MOUNT_POINTS[@]}"; do
        if mountpoint -q "$mount_point" 2>/dev/null; then
            echo ""
            echo -e "${CYAN}$mount_point:${NC}"
            sudo btrfs filesystem usage -h "$mount_point" 2>&1 | tee -a "$LOG_FILE"
        fi
    done

    echo ""
    echo -e "${CYAN}Entrées fstab:${NC}"
    grep btrfs /etc/fstab || echo "Aucune entrée BTRFS dans fstab"
}

optimize_btrfs_filesystems() {
    print_step "Optimisation des filesystems BTRFS..."

    for mount_point in "${MOUNT_POINTS[@]}"; do
        if mountpoint -q "$mount_point" 2>/dev/null; then
            print_step "Optimisation de $mount_point..."

            # Défragmentation
            sudo btrfs filesystem defragment -r -v -czstd "$mount_point" 2>&1 | tee -a "$LOG_FILE" &

            # Équilibrage
            sudo btrfs balance start -dusage=70 -musage=70 "$mount_point" 2>&1 | tee -a "$LOG_FILE" &

            # Nettoyage des snapshots
            if command -v snapper &> /dev/null; then
                sudo snapper -c root cleanup number 2>&1 | tee -a "$LOG_FILE"
            fi
        fi
    done

    print_success "Optimisation en cours en arrière-plan"
}

#######################################
# FONCTION PRINCIPALE
#######################################

main() {
    # Initialisation
    check_root
    check_dependencies
    print_header
    get_system_info
    detect_wayland
    load_config
    touch "$LOG_FILE"
    echo "=== Début du log - $(date) ===" > "$LOG_FILE"

    # Menu principal
    while true; do
        print_header
        echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║           MENU PRINCIPAL - ENDEAVOUR OS 2026          ║${NC}"
        echo -e "${CYAN}╠══════════════════════════════════════════════════╣${NC}"
        echo -e "${CYAN}║  1. Installation complète 2026                     ║${NC}"
        echo -e "${CYAN}║  2. Setup gaming 2026                             ║${NC}"
        echo -e "${CYAN}║  3. Setup terminal 2026                           ║${NC}"
        echo -e "${CYAN}║  4. Setup AI/ML 2026                              ║${NC}"
        echo -e "${CYAN}║  5. Configuration BTRFS avancée                   ║${NC}"
        echo -e "${CYAN}║  6. Mise à jour complète du système               ║${NC}"
        echo -e "${CYAN}║  7. Installer les pilotes NVIDIA                 ║${NC}"
        echo -e "${CYAN}║  8. Installer les paquets essentiels             ║${NC}"
        echo -e "${CYAN}║  9. Installer yay et applications AUR             ║${NC}"
        echo -e "${CYAN}║ 10. Appliquer les optimisations système           ║${NC}"
        echo -e "${CYAN}║ 11. Nettoyer le système                           ║${NC}"
        echo -e "${CYAN}║ 12. Voir le statut final                          ║${NC}"
        echo -e "${CYAN}║ 13. Détecter les disques BTRFS                    ║${NC}"
        echo -e "${CYAN}║ 14. Configurer les options de compatibilité       ║${NC}"
        echo -e "${CYAN}║  0. Quitter                                      ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
        echo ""
        read -p "Choisissez une option (0-14): " choice

        case $choice in
            1)
                full_installation
                ;;
            2)
                gaming_setup
                ;;
            3)
                terminal_setup
                ;;
            4)
                ai_setup
                ;;
            5)
                btrfs_menu
                ;;
            6)
                update_system
                ;;
            7)
                install_nvidia_drivers
                ;;
            8)
                install_essential_packages
                ;;
            9)
                install_yay
                install_aur_apps
                ;;
            10)
                apply_system_optimizations
                ;;
            11)
                cleanup_system
                ;;
            12)
                show_final_status
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            13)
                detect_btrfs_disks
                show_detected_disks
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            14)
                configure_skips
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            0)
                print_step "Merci d'avoir utilisé le script EndeavourOS Unified Setup 2026 !"
                echo ""
                print_step "Log disponible : $LOG_FILE"
                exit 0
                ;;
            *)
                print_error "Option invalide ! Veuillez choisir entre 0 et 14."
                sleep 2
                ;;
        esac
    done
}

# Point d'entrée du script
trap 'echo ""; print_warning "Script interrompu. Log disponible: $LOG_FILE"' INT TERM
main "$@"
