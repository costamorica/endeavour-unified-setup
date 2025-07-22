#!/bin/bash

#######################################
# Script Unifié EndeavourOS - Configuration Complète
# Regroupe : Post-installation, Gaming, Kitty+zsh, Fastfetch, Disques BTRFS
# Détection automatique des disques et configuration intelligente
# Version: 2.0.0
#######################################

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables globales
SCRIPT_VERSION="2.0.0"
LOG_FILE="/tmp/endeavour_unified_setup.log"
DETECTED_BTRFS_DISKS=()
MOUNT_POINTS=()

#######################################
# FONCTIONS UTILITAIRES
#######################################

print_header() {
    clear
    echo -e "${PURPLE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║              ENDEAVOUR OS - SETUP UNIFIÉ                ║${NC}"
    echo -e "${PURPLE}║    Post-install • Gaming • Terminal • Disques BTRFS     ║${NC}"
    echo -e "${PURPLE}║                 Version: $SCRIPT_VERSION                     ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${CYAN}[INFO]${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1" >> $LOG_FILE
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESS] $1" >> $LOG_FILE
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [WARNING] $1" >> $LOG_FILE
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> $LOG_FILE
}

check_error() {
    if [ $? -ne 0 ]; then
        print_error "$1"
        exit 1
    fi
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Ce script ne doit pas être exécuté en tant que root!"
        print_warning "Utilisez votre compte utilisateur normal."
        exit 1
    fi
}

#######################################
# DÉTECTION AUTOMATIQUE DES DISQUES BTRFS
#######################################

detect_btrfs_disks() {
    print_step "Détection automatique des disques BTRFS..."
    
    DETECTED_BTRFS_DISKS=()
    MOUNT_POINTS=()
    
    # Scanner tous les périphériques de stockage
    for device in $(lsblk -dpno NAME | grep -E '^/dev/sd[a-z]$|^/dev/nvme[0-9]+n[0-9]+$'); do
        # Vérifier si le disque entier est BTRFS
        if sudo blkid -o value -s TYPE "$device" 2>/dev/null | grep -q "btrfs"; then
            print_step "Disque BTRFS détecté: $device (disque entier)"
            DETECTED_BTRFS_DISKS+=("$device")
            continue
        fi
        
        # Vérifier les partitions
        for partition in $(lsblk -pno NAME "$device" 2>/dev/null | tail -n +2); do
            if sudo blkid -o value -s TYPE "$partition" 2>/dev/null | grep -q "btrfs"; then
                print_step "Partition BTRFS détectée: $partition"
                DETECTED_BTRFS_DISKS+=("$partition")
            fi
        done
    done
    
    if [ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]; then
        print_warning "Aucun disque BTRFS détecté"
        return 1
    fi
    
    print_success "${#DETECTED_BTRFS_DISKS[@]} disque(s) BTRFS détecté(s)"
    return 0
}

show_detected_disks() {
    if [ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]; then
        print_warning "Aucun disque BTRFS détecté"
        return
    fi
    
    echo ""
    echo -e "${BLUE}Disques BTRFS détectés:${NC}"
    echo ""
    
    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        uuid=$(sudo blkid -o value -s UUID "$disk" 2>/dev/null)
        label=$(sudo blkid -o value -s LABEL "$disk" 2>/dev/null)
        size=$(lsblk -no SIZE "$disk" 2>/dev/null)
        
        echo -e "${GREEN}[$((i+1))]${NC} $disk"
        echo "    UUID: ${uuid:-'Non défini'}"
        echo "    Label: ${label:-'Aucun'}"
        echo "    Taille: ${size:-'Inconnue'}"
        
        # Vérifier si déjà monté
        if mountpoint -q "/mnt/$(basename $disk)" 2>/dev/null; then
            echo -e "    Status: ${GREEN}Déjà monté${NC}"
        else
            echo -e "    Status: ${YELLOW}Non monté${NC}"
        fi
        echo ""
    done
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
    sudo mkdir -p "$mount_point" 2>&1 | tee -a $LOG_FILE
    
    # Démonter si déjà monté
    if mountpoint -q "$mount_point" 2>/dev/null; then
        print_step "Démontage de $mount_point..."
        sudo umount "$mount_point" 2>&1 | tee -a $LOG_FILE
    fi
    
    # Supprimer l'ancienne entrée dans fstab si elle existe
    sudo sed -i "\|$mount_point|d" /etc/fstab 2>&1 | tee -a $LOG_FILE
    
    # Ajouter la nouvelle entrée dans fstab
    print_step "Ajout dans /etc/fstab..."
    echo "UUID=$uuid $mount_point btrfs defaults,user,rw,exec,auto,noatime,space_cache=v2,compress=zstd:3 0 2" | sudo tee -a /etc/fstab 2>&1 | tee -a $LOG_FILE
    
    # Monter le disque
    print_step "Montage de $mount_point..."
    sudo mount "$mount_point" 2>&1 | tee -a $LOG_FILE
    check_error "Échec du montage de $mount_point"
    
    # Configurer les permissions
    print_step "Configuration des permissions..."
    sudo chmod 755 "$mount_point" 2>&1 | tee -a $LOG_FILE
    sudo chown $USER:users "$mount_point" 2>&1 | tee -a $LOG_FILE
    
    # Créer un lien symbolique dans le home
    if [[ ! -L "$HOME/$mount_name" ]]; then
        ln -s "$mount_point" "$HOME/$mount_name" 2>&1 | tee -a $LOG_FILE
        print_success "Lien symbolique créé: ~/$mount_name -> $mount_point"
    fi
    
    MOUNT_POINTS+=("$mount_point")
    print_success "$disk configuré et monté sur $mount_point"
}

auto_configure_btrfs_disks() {
    if [ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]; then
        print_warning "Aucun disque BTRFS à configurer"
        return
    fi
    
    print_step "Configuration automatique des disques BTRFS..."
    
    # Installation des outils BTRFS
    sudo pacman -S --noconfirm btrfs-progs 2>&1 | tee -a $LOG_FILE
    check_error "Échec de l'installation des outils BTRFS"
    
    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        label=$(sudo blkid -o value -s LABEL "$disk" 2>/dev/null)
        
        # Déterminer le nom de montage
        if [[ -n "$label" ]]; then
            mount_name=$(echo "$label" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]//g')
        else
            case "$disk" in
                */sda*) mount_name="nas" ;;
                */sdb*) mount_name="games" ;;
                */sdc*) mount_name="data" ;;
                *nvme0n1*) mount_name="nvme1" ;;
                *nvme1n1*) mount_name="nvme2" ;;
                *) mount_name="disk$((i+1))" ;;
            esac
        fi
        
        configure_btrfs_disk "$disk" "$mount_name"
    done
    
    # Optimisation BTRFS en arrière-plan
    print_step "Optimisation BTRFS en cours (arrière-plan)..."
    for mount_point in "${MOUNT_POINTS[@]}"; do
        if mountpoint -q "$mount_point"; then
            sudo btrfs filesystem defragment -r -v -czstd "$mount_point" 2>&1 | tee -a $LOG_FILE &
        fi
    done
    
    print_success "Configuration BTRFS terminée"
}

#######################################
# POST-INSTALLATION SYSTÈME
#######################################

update_system() {
    print_step "Mise à jour du système..."
    sudo pacman -Syu --noconfirm 2>&1 | tee -a $LOG_FILE
    check_error "Échec de la mise à jour du système"
    print_success "Système mis à jour"
}

install_nvidia_drivers() {
    if lspci | grep -i nvidia > /dev/null; then
        print_step "Carte NVIDIA détectée. Installation des pilotes..."
        sudo pacman -S --noconfirm nvidia nvidia-lts nvidia-utils nvidia-settings 2>&1 | tee -a $LOG_FILE
        print_success "Pilotes NVIDIA installés"
    else
        print_step "Aucune carte NVIDIA détectée"
    fi
}

install_essential_packages() {
    print_step "Installation des paquets essentiels..."
    
    ESSENTIAL_PACKAGES=(
        # Développement
        "base-devel" "git" "vim" "nano" "wget" "curl" "htop" "tree" "unzip" "zip" 
        "p7zip" "rsync" "openssh" "bash-completion"
        
        # Multimédia
        "ffmpeg" "gst-plugins-base" "gst-plugins-good" "gst-plugins-bad" 
        "gst-plugins-ugly" "gst-libav" "libdvdcss" "x264" "x265" "lame"
        
        # Polices
        "ttf-liberation" "ttf-dejavu" "ttf-roboto" "noto-fonts" "noto-fonts-emoji" 
        "adobe-source-code-pro-fonts"
        
        # Applications
        "firefox" "vlc" "libreoffice-fresh" "gimp" "thunderbird" "gparted" 
        "bleachbit" "timeshift" "gufw" "ark"
        
        # Outils modernes
        "exa" "bat" "fd" "ripgrep" "fzf" "neofetch"
    )
    
    for package in "${ESSENTIAL_PACKAGES[@]}"; do
        sudo pacman -S --noconfirm "$package" 2>/dev/null || print_warning "$package non disponible"
    done 2>&1 | tee -a $LOG_FILE
    
    print_success "Paquets essentiels installés"
}

install_yay() {
    if ! command -v yay &> /dev/null; then
        print_step "Installation de yay (AUR helper)..."
        cd /tmp
        git clone https://aur.archlinux.org/yay.git 2>&1 | tee -a $LOG_FILE
        cd yay
        makepkg -si --noconfirm 2>&1 | tee -a $LOG_FILE
        cd ~
        print_success "yay installé"
    else
        print_step "yay déjà installé"
    fi
}

install_aur_apps() {
    print_step "Installation d'applications AUR..."
    
    AUR_APPS=(
        "google-chrome"
        "visual-studio-code-bin" 
        "discord"
        "spotify"
        "zoom"
    )
    
    for app in "${AUR_APPS[@]}"; do
        yay -S --noconfirm "$app" 2>&1 | tee -a $LOG_FILE
    done
    
    print_success "Applications AUR installées"
}

#######################################
# GAMING SETUP
#######################################

install_gaming_tools() {
    print_step "Installation des outils gaming..."
    
    # Activer multilib
    sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf 2>&1 | tee -a $LOG_FILE
    sudo pacman -Sy 2>&1 | tee -a $LOG_FILE
    
    # Steam et gaming tools
    GAMING_PACKAGES=(
        "steam" "lutris" "wine" "wine-gecko" "wine-mono" "winetricks"
        "lib32-vulkan-icd-loader" "vulkan-icd-loader" "lib32-mesa" "mesa"
        "mangohud" "lib32-mangohud" "goverlay" "gamemode" "lib32-gamemode"
        "jstest-gtk" "antimicrox" "lib32-gnutls" "lib32-libldap" "lib32-libpulse"
    )
    
    for package in "${GAMING_PACKAGES[@]}"; do
        sudo pacman -S --noconfirm "$package" 2>/dev/null || print_warning "$package non disponible"
    done 2>&1 | tee -a $LOG_FILE
    
    # AUR gaming apps
    if command -v yay &> /dev/null; then
        yay -S --noconfirm heroic-games-launcher-bin protonup-qt 2>&1 | tee -a $LOG_FILE
    fi
    
    # Configuration GameMode
    sudo usermod -aG gamemode $USER 2>&1 | tee -a $LOG_FILE
    sudo systemctl enable --now gamemode 2>&1 | tee -a $LOG_FILE
    
    # Configuration MangoHud
    mkdir -p ~/.config/MangoHud
    cat > ~/.config/MangoHud/MangoHud.conf << 'EOF'
toggle_hud=Shift_R+F12
position=top-left
font_size=24
background_alpha=0.5
fps
cpu_stats
cpu_temp
gpu_stats
gpu_temp
ram
vram
cpu_color=00AAFF
gpu_color=00FF00
fps_color=FFFFFF
EOF
    
    print_success "Outils gaming installés"
}

#######################################
# TERMINAL SETUP (KITTY + ZSH)
#######################################

install_terminal_setup() {
    print_step "Installation et configuration du terminal..."
    
    # Installation des paquets
    sudo pacman -S --noconfirm kitty zsh zsh-completions 2>&1 | tee -a $LOG_FILE
    
    # Nerd Fonts
    NERD_FONTS=("ttf-meslo-nerd" "ttf-fira-code" "ttf-jetbrains-mono-nerd" "noto-fonts-emoji")
    for font in "${NERD_FONTS[@]}"; do
        sudo pacman -S --noconfirm "$font" 2>/dev/null || print_warning "$font non disponible"
    done 2>&1 | tee -a $LOG_FILE
    
    # Oh My Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>&1 | tee -a $LOG_FILE
    fi
    
    # Powerlevel10k
    P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ ! -d "$P10K_DIR" ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR" 2>&1 | tee -a $LOG_FILE
    fi
    
    # Plugins zsh
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
    
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>&1 | tee -a $LOG_FILE
    fi
    
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>&1 | tee -a $LOG_FILE
    fi
    
    print_success "Terminal installé"
}

configure_kitty() {
    print_step "Configuration de Kitty..."
    
    mkdir -p "$HOME/.config/kitty"
    cat > "$HOME/.config/kitty/kitty.conf" << 'EOF'
# Configuration Kitty - Thème Bleu Cyan Transparent

font_family      JetBrainsMono Nerd Font
font_size        12.0
cursor_shape block
cursor_blink_interval 0.5
scrollback_lines 10000
detect_urls yes
repaint_delay 10
input_delay 3
enable_audio_bell no
remember_window_size no
initial_window_width 120c
initial_window_height 30c
window_padding_width 8
background_opacity 0.85
dynamic_background_opacity yes

# Thème Bleu Cyan
foreground #E0FFFF
background #001122
selection_foreground #000000
selection_background #00CCFF
cursor #00FFFF
cursor_text_color #001122

# Couleurs normales
color0  #000000
color1  #FF6B6B
color2  #4ECDC4
color3  #45B7D1
color4  #96CEB4
color5  #FECCA7
color6  #00FFFF
color7  #E0FFFF

# Couleurs brillantes
color8  #4A5568
color9  #FF8E8E
color10 #81E6D9
color11 #68D8F0
color12 #B2F5EA
color13 #FFEAA7
color14 #9DECF9
color15 #FFFFFF

# Raccourcis
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard
map ctrl+shift+t new_tab
map ctrl+shift+w close_tab
map ctrl+shift+equal change_font_size all +2.0
map ctrl+shift+minus change_font_size all -2.0

# Onglets
active_tab_foreground   #001122
active_tab_background   #00FFFF
inactive_tab_foreground #81E6D9
inactive_tab_background #2D3748
tab_bar_background      #1A202C
tab_bar_style powerline
tab_powerline_style round

shell zsh
EOF
    
    print_success "Kitty configuré"
}

configure_zsh() {
    print_step "Configuration de zsh..."
    
    # Backup
    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    cat > "$HOME/.zshrc" << 'EOF'
# Configuration zsh avec Oh My Zsh et Powerlevel10k
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    sudo
    extract
    systemd
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nano'

# Aliases utiles
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Outils modernes
if command -v exa > /dev/null; then
    alias ls='exa --icons'
    alias ll='exa -la --icons'
    alias tree='exa --tree --icons'
fi

if command -v bat > /dev/null; then
    alias cat='bat --paging=never'
fi

# Fastfetch au démarrage
if command -v fastfetch > /dev/null 2>&1; then
    if [[ $SHLVL -eq 1 ]]; then
        sleep 0.2
        fastfetch 2>/dev/null || true
        echo ""
    fi
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF
    
    # Configuration P10k
    cat > "$HOME/.p10k.zsh" << 'EOF'
# Configuration Powerlevel10k - Thème Bleu Cyan
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    dir
    vcs
    prompt_char
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    time
)

typeset -g POWERLEVEL9K_COLOR_SCHEME='dark'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=cyan
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=red
typeset -g POWERLEVEL9K_DIR_FOREGROUND=white
typeset -g POWERLEVEL9K_DIR_BACKGROUND=blue
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=black
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=green
typeset -g POWERLEVEL9K_TIME_FOREGROUND=cyan
typeset -g POWERLEVEL9K_TIME_BACKGROUND=black
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=cyan
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
EOF
    
    # Changer le shell par défaut
    if [[ "$SHELL" != *"zsh"* ]]; then
        chsh -s $(which zsh) 2>&1 | tee -a $LOG_FILE
    fi
    
    print_success "zsh configuré"
}

#######################################
# FASTFETCH SETUP
#######################################

install_and_configure_fastfetch() {
    print_step "Installation et configuration de Fastfetch..."
    
    # Installation
    sudo pacman -S --noconfirm fastfetch 2>&1 | tee -a $LOG_FILE || {
        if command -v yay &> /dev/null; then
            yay -S --noconfirm fastfetch 2>&1 | tee -a $LOG_FILE
        fi
    }
    
    # Configuration
    mkdir -p "$HOME/.config/fastfetch"
    cat > "$HOME/.config/fastfetch/config.jsonc" << 'EOF'
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "source": "endeavouros",
        "padding": {"top": 1, "left": 3},
        "color": {"1": "cyan", "2": "blue"}
    },
    "display": {
        "separator": " ❯ ",
        "color": {"separator": "cyan", "keys": "blue", "output": "cyan"}
    },
    "modules": [
        {
            "type": "title",
            "color": {"user": "cyan", "at": "blue", "host": "cyan"}
        },
        {
            "type": "separator",
            "string": "╭──────────────────────────────────╮"
        },
        {
            "type": "custom",
            "format": "│           💻 SYSTÈME             │"
        },
        {
            "type": "separator",
            "string": "├──────────────────────────────────┤"
        },
        {
            "type": "os",
            "key": "│ 󰍹 OS",
            "keyColor": "blue"
        },
        {
            "type": "host",
            "key": "│ 󰟀 Host",
            "keyColor": "cyan"
        },
        {
            "type": "kernel",
            "key": "│  Kernel",
            "keyColor": "blue"
        },
        {
            "type": "uptime",
            "key": "│ 󰅐 Uptime",
            "keyColor": "cyan"
        },
        {
            "type": "packages",
            "key": "│ 󰆧 Packages",
            "keyColor": "blue"
        },
        {
            "type": "shell",
            "key": "│  Shell",
            "keyColor": "cyan"
        },
        {
            "type": "separator",
            "string": "├──────────────────────────────────┤"
        },
        {
            "type": "custom",
            "format": "│          ⚙️  HARDWARE            │"
        },
        {
            "type": "separator",
            "string": "├──────────────────────────────────┤"
        },
        {
            "type": "cpu",
            "key": "│ 󰻠 CPU",
            "keyColor": "blue"
        },
        {
            "type": "gpu",
            "key": "│ 󰢮 GPU",
            "keyColor": "cyan"
        },
        {
            "type": "memory",
            "key": "│  Memory",
            "keyColor": "blue"
        },
        {
            "type": "disk",
            "key": "│ 󰋊 Disk (/)",
            "keyColor": "cyan"
        },
        {
            "type": "separator",
            "string": "├──────────────────────────────────┤"
        },
        {
            "type": "custom",
            "format": "│          🖥️  INTERFACE           │"
        },
        {
            "type": "separator",
            "string": "├──────────────────────────────────┤"
        },
        {
            "type": "de",
            "key": "│ 󰧨 DE",
            "keyColor": "blue"
        },
        {
            "type": "wm",
            "key": "│  WM",
            "keyColor": "cyan"
        },
        {
            "type": "terminal",
            "key": "│  Terminal",
            "keyColor": "blue"
        },
        {
            "type": "separator",
            "string": "╰──────────────────────────────────╯"
        },
        {
            "type": "break"
        },
        {
            "type": "colors",
            "paddingLeft": 3,
            "symbol": "circle"
        }
    ]
}
EOF
    
    print_success "Fastfetch configuré"
}

#######################################
# OPTIMISATIONS SYSTÈME
#######################################

apply_system_optimizations() {
    print_step "Application des optimisations système..."
    
    # Configuration de pacman
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
    
    # Services
    sudo systemctl enable bluetooth NetworkManager ufw 2>&1 | tee -a $LOG_FILE
    sudo ufw enable 2>&1 | tee -a $LOG_FILE
    
    # Swappiness
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/99-swappiness.conf 2>&1 | tee -a $LOG_FILE
    
    # Optimisations gaming
    echo 'vm.max_map_count=2147483642' | sudo tee -a /etc/sysctl.d/99-gaming.conf 2>&1 | tee -a $LOG_FILE
    echo 'kernel.nmi_watchdog=0' | sudo tee -a /etc/sysctl.d/99-gaming.conf 2>&1 | tee -a $LOG_FILE
    
    # Variables d'environnement gaming
    cat >> ~/.bashrc << 'EOF'

# Configuration Gaming Linux
export WINE_CPU_TOPOLOGY=4:2
export DXVK_HUD=fps
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv_GLCache"
EOF
    
    print_success "Optimisations système appliquées"
}

#######################################
# NETTOYAGE SYSTÈME
#######################################

cleanup_system() {
    print_step "Nettoyage du système..."
    
    # Nettoyage des paquets orphelins
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true
    
    # Nettoyage du cache pacman
    sudo pacman -Scc --noconfirm 2>&1 | tee -a $LOG_FILE
    
    # Nettoyage yay si disponible
    if command -v yay &> /dev/null; then
        yay -Ycc --noconfirm 2>&1 | tee -a $LOG_FILE
    fi
    
    print_success "Système nettoyé"
}

#######################################
# AFFICHAGE DU STATUT FINAL
#######################################

show_final_status() {
    echo ""
    print_success "Configuration terminée !"
    echo ""
    
    print_step "Résumé de la configuration:"
    echo -e "  ${GREEN}✓${NC} Système mis à jour et optimisé"
    echo -e "  ${GREEN}✓${NC} Paquets essentiels installés"
    echo -e "  ${GREEN}✓${NC} yay (AUR helper) configuré"
    echo -e "  ${GREEN}✓${NC} Applications AUR installées"
    
    if lspci | grep -i nvidia > /dev/null; then
        echo -e "  ${GREEN}✓${NC} Pilotes NVIDIA installés"
    fi
    
    echo -e "  ${GREEN}✓${NC} Outils gaming installés (Steam, Lutris, etc.)"
    echo -e "  ${GREEN}✓${NC} MangoHud et GameMode configurés"
    echo -e "  ${GREEN}✓${NC} Kitty terminal avec thème bleu cyan"
    echo -e "  ${GREEN}✓${NC} zsh + Oh My Zsh + Powerlevel10k"
    echo -e "  ${GREEN}✓${NC} Fastfetch configuré"
    
    if [ ${#DETECTED_BTRFS_DISKS[@]} -gt 0 ]; then
        echo -e "  ${GREEN}✓${NC} ${#DETECTED_BTRFS_DISKS[@]} disque(s) BTRFS configuré(s)"
        echo ""
        print_step "Disques BTRFS montés:"
        for mount_point in "${MOUNT_POINTS[@]}"; do
            if mountpoint -q "$mount_point" 2>/dev/null; then
                echo -e "    ${GREEN}•${NC} $mount_point (accessible via ~/$(basename $mount_point))"
            fi
        done
    fi
    
    echo ""
    print_step "Points de montage dans fstab:"
    grep -E "(nas|games|data|nvme|disk)" /etc/fstab 2>/dev/null || print_warning "Aucune entrée BTRFS trouvée"
    
    echo ""
    print_step "Liens symboliques créés:"
    ls -la "$HOME/" | grep -E "(NAS|Games|Data|nas|games|data|nvme|disk)" || print_warning "Aucun lien trouvé"
    
    echo ""
    print_warning "Actions recommandées après le redémarrage :"
    echo -e "${CYAN}1.${NC} Ouvrir Kitty comme terminal par défaut"
    echo -e "${CYAN}2.${NC} Lancer 'p10k configure' pour personnaliser le prompt"
    echo -e "${CYAN}3.${NC} Configurer Steam avec : mangohud gamemoderun %command%"
    echo -e "${CYAN}4.${NC} Installer Proton-GE avec ProtonUp-Qt"
    
    echo ""
    print_step "Fichiers de configuration créés :"
    echo -e "  • ~/.config/kitty/kitty.conf"
    echo -e "  • ~/.config/fastfetch/config.jsonc"
    echo -e "  • ~/.config/MangoHud/MangoHud.conf"
    echo -e "  • ~/.zshrc et ~/.p10k.zsh"
    
    echo ""
    print_step "Log complet disponible : $LOG_FILE"
}

#######################################
# MENU INTERACTIF
#######################################

show_main_menu() {
    print_header
    
    # Afficher les disques BTRFS détectés
    detect_btrfs_disks
    show_detected_disks
    
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}                    MENU PRINCIPAL                         ${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}Configurations complètes :${NC}"
    echo "  1) 🚀 Installation COMPLÈTE (tout en un)"
    echo "  2) 🎮 Setup GAMING complet"
    echo "  3) 💻 Setup TERMINAL complet (Kitty + zsh)"
    echo ""
    echo -e "${GREEN}Modules individuels :${NC}"
    echo "  4) 📦 Post-installation système"
    echo "  5) 💾 Configuration disques BTRFS"
    echo "  6) 🎯 Outils gaming seulement"
    echo "  7) 🖥️  Terminal (Kitty) seulement"
    echo "  8) 🐚 Shell (zsh + Oh My Zsh) seulement"
    echo "  9) ⚡ Fastfetch seulement"
    echo "  10) 🔧 Optimisations système"
    echo "  11) 🧹 Nettoyage système"
    echo ""
    echo -e "${GREEN}Informations :${NC}"
    echo "  12) 📊 Afficher le statut actuel"
    echo "  13) 💿 Détecter les disques BTRFS"
    echo ""
    echo "  0) ❌ Quitter"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    read -p "Votre choix [0-13]: " choice
    echo ""
}

#######################################
# INSTALLATIONS GROUPÉES
#######################################

full_installation() {
    print_step "🚀 INSTALLATION COMPLÈTE DÉMARRÉE"
    print_step "Cette installation peut prendre 30-60 minutes..."
    echo ""
    
    # Phase 1 : Système de base
    print_step "Phase 1/5 : Système de base..."
    update_system
    install_nvidia_drivers
    install_essential_packages
    install_yay
    install_aur_apps
    
    # Phase 2 : Gaming
    print_step "Phase 2/5 : Outils gaming..."
    install_gaming_tools
    
    # Phase 3 : Terminal
    print_step "Phase 3/5 : Configuration terminal..."
    install_terminal_setup
    configure_kitty
    configure_zsh
    
    # Phase 4 : Fastfetch
    print_step "Phase 4/5 : Fastfetch..."
    install_and_configure_fastfetch
    
    # Phase 5 : Disques et optimisations
    print_step "Phase 5/5 : Disques BTRFS et optimisations..."
    auto_configure_btrfs_disks
    apply_system_optimizations
    cleanup_system
    
    show_final_status
    
    echo ""
    print_success "🎉 INSTALLATION COMPLÈTE TERMINÉE !"
    ask_for_reboot
}

gaming_setup() {
    print_step "🎮 SETUP GAMING COMPLET DÉMARRÉ"
    
    update_system
    install_gaming_tools
    apply_system_optimizations
    
    echo ""
    print_success "🎮 Setup gaming terminé !"
    echo ""
    print_step "Pour utiliser MangoHud et GameMode avec Steam :"
    echo -e "${CYAN}• Clic droit sur un jeu > Propriétés > Options de lancement${NC}"
    echo -e "${CYAN}• Ajouter : mangohud gamemoderun %command%${NC}"
    
    ask_for_reboot
}

terminal_setup() {
    print_step "💻 SETUP TERMINAL COMPLET DÉMARRÉ"
    
    install_terminal_setup
    configure_kitty
    configure_zsh
    install_and_configure_fastfetch
    
    echo ""
    print_success "💻 Setup terminal terminé !"
    echo ""
    print_step "Pour utiliser la nouvelle configuration :"
    echo -e "${CYAN}• Fermez ce terminal et ouvrez Kitty${NC}"
    echo -e "${CYAN}• Lancez 'p10k configure' pour personnaliser${NC}"
    
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

#######################################
# MENU DE CONFIGURATION BTRFS AVANCÉ
#######################################

btrfs_advanced_menu() {
    if [ ${#DETECTED_BTRFS_DISKS[@]} -eq 0 ]; then
        print_warning "Aucun disque BTRFS détecté"
        return
    fi
    
    echo ""
    echo -e "${BLUE}Configuration avancée des disques BTRFS${NC}"
    echo ""
    
    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        echo -e "${GREEN}[$((i+1))]${NC} $disk"
    done
    
    echo ""
    echo "a) Configuration automatique (recommandée)"
    echo "m) Configuration manuelle"
    echo "s) Afficher le statut des montages"
    echo "o) Optimiser les filesystems BTRFS"
    echo "r) Retour au menu principal"
    echo ""
    read -p "Votre choix: " btrfs_choice
    
    case $btrfs_choice in
        a|A)
            auto_configure_btrfs_disks
            ;;
        m|M)
            manual_btrfs_configuration
            ;;
        s|S)
            show_btrfs_status
            ;;
        o|O)
            optimize_btrfs_filesystems
            ;;
        r|R)
            return
            ;;
        *)
            print_error "Option invalide"
            ;;
    esac
}

manual_btrfs_configuration() {
    for i in "${!DETECTED_BTRFS_DISKS[@]}"; do
        disk="${DETECTED_BTRFS_DISKS[$i]}"
        echo ""
        echo -e "${CYAN}Configuration de $disk${NC}"
        read -p "Nom du point de montage (ex: nas, games, data): " mount_name
        
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
    
    df -h | grep btrfs || print_warning "Aucun filesystem BTRFS monté"
    
    echo ""
    print_step "Entrées fstab BTRFS:"
    grep btrfs /etc/fstab || print_warning "Aucune entrée BTRFS dans fstab"
}

optimize_btrfs_filesystems() {
    print_step "Optimisation des filesystems BTRFS..."
    
    for mount_point in "${MOUNT_POINTS[@]}"; do
        if mountpoint -q "$mount_point" 2>/dev/null; then
            print_step "Optimisation de $mount_point..."
            sudo btrfs filesystem defragment -r -v -czstd "$mount_point" 2>&1 | tee -a $LOG_FILE &
        fi
    done
    
    print_success "Optimisation en cours en arrière-plan"
}

#######################################
# FONCTION PRINCIPALE
#######################################

main() {
    # Vérifications préliminaires
    check_root
    
    # Initialisation du log
    touch $LOG_FILE
    echo "=== EndeavourOS Unified Setup - Session démarrée le $(date) ===" >> $LOG_FILE
    
    while true; do
        show_main_menu
        
        case $choice in
            1)
                full_installation
                break
                ;;
            2)
                gaming_setup
                break
                ;;
            3)
                terminal_setup
                break
                ;;
            4)
                print_step "Post-installation système..."
                update_system
                install_nvidia_drivers
                install_essential_packages
                install_yay
                install_aur_apps
                apply_system_optimizations
                cleanup_system
                print_success "Post-installation terminée"
                ;;
            5)
                btrfs_advanced_menu
                ;;
            6)
                install_gaming_tools
                ;;
            7)
                install_terminal_setup
                configure_kitty
                ;;
            8)
                install_terminal_setup
                configure_zsh
                ;;
            9)
                install_and_configure_fastfetch
                ;;
            10)
                apply_system_optimizations
                ;;
            11)
                cleanup_system
                ;;
            12)
                show_final_status
                ;;
            13)
                detect_btrfs_disks
                show_detected_disks
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
            0)
                print_step "Merci d'avoir utilisé le script EndeavourOS Unified Setup !"
                echo ""
                print_step "Log disponible : $LOG_FILE"
                exit 0
                ;;
            *)
                print_error "Option invalide ! Veuillez choisir entre 0 et 13."
                sleep 2
                ;;
        esac
        
        if [[ $choice != 5 && $choice != 12 && $choice != 13 ]]; then
            echo ""
            read -p "Appuyez sur Entrée pour retourner au menu principal..."
        fi
    done
}

# Point d'entrée du script
main "$@"