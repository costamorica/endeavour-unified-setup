🚀 EndeavourOS Unified Setup 2026
Script tout-en-un pour EndeavourOS - Post-installation, Gaming, AI, Terminal moderne, BTRFS et Wayland
<img src="https://img.shields.io/badge/Version-3.0.0-blue?style=for-the-badge" alt="Version" />
<img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT" />
<img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell: Bash" />
<img src="https://img.shields.io/badge/EndeavourOS-Compatible-7F5AB6?style=for-the-badge&logo=linux&logoColor=white" alt="EndeavourOS" />
<img src="https://img.shields.io/badge/Wayland-Supported-0078D4?style=for-the-badge&logo=wayland&logoColor=white" alt="Wayland" />

📋 Table des matières

✨ Nouveautés 2026
🎯 Fonctionnalités
📥 Installation
📦 Ce qui est installé
🖥️ Configuration terminal
🎮 Setup gaming
🤖 AI & Machine Learning
💾 Gestion BTRFS
🔧 Optimisations système
📸 Captures d'écran
🔧 Utilisation avancée
🆘 Dépannage
🤝 Contribution
📄 Licence


✨ Nouveautés 2026
Copier le tableau


Fonctionnalité
Description



🚀 Wayland natif
Support complet pour Wayland (NVIDIA/AMD) avec optimisations


🤖 AI/ML Tools
Installation de PyTorch, TensorFlow, Ollama, Stable Diffusion


🎮 Gaming 2026
Proton-GE, DXVK, VKD3D-Proton, MangoHud, GameMode


💻 Terminal moderne
Starship, Zoxide, Eza, Bat, Kitty (thème cyberpunk)


🗃️ BTRFS optimisé
discard=async, zstd:3, équilibrage automatique


⚡ Optimisations système
EarlyOOM, TLP, Kernel 6.8+, PipeWire, NVIDIA 550+


📦 AUR avancé
Installation automatique de 100+ paquets AUR (yay)


🧹 Nettoyage intelligent
Suppression des anciens kernels, cache, journaux



🎯 Fonctionnalités
🔥 Installation complète en un clic

Post-installation système avec Kernel 6.8+
Configuration gaming optimisée (Proton-GE, DXVK, VKD3D)
Terminal moderne avec thème personnalisé (Starship, Kitty)
Détection et configuration automatique des disques BTRFS
Support Wayland et X11 (détection automatique)

🎨 Interface utilisateur moderne

Menu interactif coloré et intuitif (icônes, emojis)
Logs détaillés en temps réel (/tmp/endeavour_unified_setup_YYYYMMDD.log)
Gestion d'erreurs intelligente avec suggestions
Affichage du statut final avec recommandations

💾 Gestion BTRFS intelligente

Détection automatique de tous les disques BTRFS (/dev/sd*, /dev/nvme*)
Configuration optimisée avec compression Zstandard (zstd:3)
Points de montage automatiques dans /mnt/ (ex: /mnt/games)
Liens symboliques dans ~/Storage/ (ex: ~/Storage/Games)
Optimisation en arrière-plan (défragmentation, équilibrage)

🎮 Gaming-ready 2026

Steam, Lutris, Heroic Games Launcher, Bottles
MangoHud (overlay de performance) + GameMode (optimisation automatique)
Proton-GE, DXVK, VKD3D-Proton (meilleure compatibilité)
Support manettes avancé (XInput, SDL2, Wayland)
Pilotes NVIDIA automatiques (550+, DLSS, ReBar)

💻 Terminal de nouvelle génération

Kitty (terminal GPU-accéléré) avec thème cyberpunk
zsh + Oh My Zsh + Starship (remplace Powerlevel10k)
Fastfetch (alternative moderne à Neofetch)
Outils modernes : Eza (ls), Bat (cat), Zoxide (cd), Ripgrep (grep)

🤖 AI & Machine Learning

Ollama (modèles Llama3, Mistral, Phi-3)
PyTorch + TensorFlow (CUDA/ROCm)
Stable Diffusion + ComfyUI (génération d'images)
JupyterLab (notebooks interactifs)


📥 Installation
Prérequis

EndeavourOS ou Arch Linux fraîchement installé
Connexion Internet active
Compte utilisateur non-root avec droits sudo

Installation en une ligne
curl -fsSL https://raw.githubusercontent.com/costamorica/endeavour-unified-setup/main/endeavour_unified_setup.sh | bash
Installation manuelle
# Clonage du dépôt
git clone https://github.com/costamorica/endeavour-unified-setup.git
cd endeavour-unified-setup

# Rendre exécutable
chmod +x endeavour_unified_setup.sh

# Lancer l'installation
./endeavour_unified_setup.sh

📦 Ce qui est installé
🔨 Outils système
base-devel, git, vim, nano, wget, curl, htop, btop, tree, unzip, zip, p7zip, rsync, openssh, bash-completion
earlyoom, tlp, reflector, pacman-contrib, pipewire, wireplumber, pavucontrol
🎵 Multimédia
ffmpeg, gstreamer, gst-plugins-good, gst-plugins-bad, gst-plugins-ugly, gst-libav
libdvdcss, x264, x265, lame, aom, dav1d, libva-mesa-driver
🎨 Polices
ttf-liberation, ttf-dejavu, noto-fonts, noto-fonts-emoji, noto-fonts-cjk
nerd-fonts, adobe-source-code-pro-fonts, ttf-jetbrains-mono-nerd
📱 Applications
firefox, vlc, libreoffice-fresh, gimp, thunderbird, gparted, bleachbit, timeshift
google-chrome, visual-studio-code-bin, discord, spotify, zoom (via AUR)
🎮 Gaming
steam, lutris, heroic-games-launcher-bin, bottles, mangohud, gamemode
wine-staging, wine-gecko, wine-mono, winetricks, protonup-qt
lib32-vulkan-icd-loader, vulkan-icd-loader, lib32-mesa, mesa
⚡ Outils modernes
exa (eza), bat, fd, ripgrep, fzf, zoxide, fastfetch, starship
kitty, zsh, oh-my-zsh-git, zsh-autosuggestions, zsh-syntax-highlighting
🤖 AI/ML
python-pytorch, python-tensorflow, jupyterlab, ollama, stable-diffusion-webui
python-pip, python-numpy, python-pandas, python-matplotlib

🖥️ Configuration terminal
Kitty (Terminal moderne)

Thème : Cyberpunk (bleu électrique + transparence)
Police : JetBrains Mono Nerd Font (10pt)
Raccourcis :
Ctrl+Shift+T → Nouvel onglet
Ctrl+Shift+W → Fermer l'onglet
Ctrl+Shift+F → Plein écran


Transparence : 90% (réglable dans ~/.config/kitty/kitty.conf)

zsh + Starship

Thème : Starship (remplace Powerlevel10k)
Plugins :
git (status, branches)
zsh-autosuggestions (suggestions intelligentes)
zsh-syntax-highlighting (couleurs de syntaxe)
sudo (double Esc pour sudo)


Aliases :alias ll='eza -la --icons --group-directories-first'
alias cat='bat --paging=never'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'


Fastfetch

Configuration personnalisée :
Logo EndeavourOS avec couleurs cyan/bleu
Sections organisées : Système, Hardware, Interface
Affichage des paquets installés, kernel, GPU, RAM


Lancement automatique au démarrage de zsh


🎮 Setup gaming
Outils installés
Copier le tableau


Outil
Description



Steam
Client gaming principal (avec Proton-GE)


Lutris
Gestionnaire multi-plateformes (Wine, DXVK)


Heroic
Client Epic Games/GOG


Bottles
Gestion des préfixes Wine


MangoHud
Overlay de performance (FPS, CPU, GPU)


GameMode
Optimisation automatique des jeux


ProtonUp-Qt
Gestionnaire de versions Proton


Configuration recommandée

Dans Steam :

Paramètres → Steam Play → ✅ Activer Steam Play pour tous les titres
✅ Utiliser Proton Experimental
Pour chaque jeu : Options de lancement → mangohud gamemoderun %command%


Pour Vulkan :
# Variables d'environnement (ajoutées automatiquement dans ~/.bashrc)
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
export DXVK_HUD=fps
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv_GLCache"


Optimisations NVIDIA

Pilotes : nvidia-dkms (550+)
CoolBits : Activation des options avancées
DLSS : Support natif dans les jeux compatibles
ReBar : Resizable BAR pour les cartes récentes


🤖 AI & Machine Learning
Outils installés
Copier le tableau


Outil
Description



Ollama
Exécution locale de modèles LLM (Llama3, Mistral)


PyTorch
Framework de deep learning (CUDA/ROCm)


TensorFlow
Alternative à PyTorch


JupyterLab
Environnement de notebooks interactifs


Stable Diffusion
Génération d'images (WebUI + ComfyUI)


Utilisation d'Ollama
# Télécharger un modèle
ollama pull llama3

# Lancer une session interactive
ollama run llama3

# Modèles disponibles :
# - llama3 (Meta)
# - mistral (Mistral AI)
# - phi3 (Microsoft)
# - gemma (Google)
Stable Diffusion

Installation automatique de stable-diffusion-webui (AUTOMATIC1111)
ComfyUI pour les workflows avancés
Optimisations CUDA pour NVIDIA


💾 Gestion BTRFS
Détection automatique
Le script détecte automatiquement :

Disques entiers formatés en BTRFS (/dev/sd*, /dev/nvme*)
Partitions BTRFS sur tous les périphériques
Labels des volumes (ex: nas, games, data)

Points de montage intelligents
Copier le tableau


Disque
Point de montage
Lien symbolique



/dev/sda1
/mnt/nas
~/Storage/NAS


/dev/nvme0n1p2
/mnt/games
~/Storage/Games


/dev/sdb1 (label data)
/mnt/data
~/Storage/Data


Options BTRFS optimisées (2026)
UUID=1234-5678 /mnt/games btrfs defaults,user,rw,exec,auto,noatime,space_cache=v2,compress=zstd:3,discard=async 0 2

discard=async : TRIM automatique en arrière-plan
compress=zstd:3 : Compression Zstandard (niveau 3)
space_cache=v2 : Cache d'espace optimisé

Commandes utiles
# Voir l'utilisation du disque
sudo btrfs filesystem usage /mnt/games

# Équilibrer le filesystem
sudo btrfs balance start /mnt/games

# Défragmenter avec compression
sudo btrfs filesystem defrag -r -v -czstd /mnt/games

🔧 Optimisations système
Optimisations appliquées
Copier le tableau


Optimisation
Description



EarlyOOM
Tue les processus gourmands avant le freeze


TLP
Gestion intelligente de l'énergie (CPU/GPU)


Kernel 6.8+
Dernières optimisations pour le gaming/AI


PipeWire
Audio moderne (remplace PulseAudio)


NVIDIA 550+
Support Wayland, DLSS, ReBar


Variables gaming
__GL_THREADED_OPTIMIZATIONS=1, DXVK_HUD=fps


Vérification des optimisations
# Vérifier le scheduler disque
cat /sys/block/sda/queue/scheduler

# Vérifier les variables gaming
env | grep -E "WINE|DXVK|__GL"

# Vérifier le kernel
uname -r

# Vérifier EarlyOOM
systemctl status earlyoom

📸 Captures d'écran
Menu principal (2026)

Menu interactif avec icônes et couleurs modernes
Fastfetch

Affichage système personnalisé avec logo EndeavourOS
Terminal Kitty + Starship

Thème cyberpunk avec transparence et blur
Gaming (MangoHud + GameMode)

Overlay de performance en jeu

🔧 Utilisation avancée
Options de menu
Copier le tableau


Option
Description
Durée estimée



1
Installation complète (tout en un)
30-60 min


2
Setup gaming optimisé
15-30 min


3
Setup terminal moderne
10-15 min


4
Installation outils AI/ML
20-40 min


5
Configuration BTRFS avancée
5-10 min


6
Post-installation système
10-20 min


7
Optimisations système
5 min


8
Nettoyage du système
2 min


Logs et débogage
# Consulter les logs
tail -f /tmp/endeavour_unified_setup_$(date +%Y%m%d).log

# Vérifier le statut des montages BTRFS
df -h | grep btrfs

# Tester la configuration terminal
fastfetch --config ~/.config/fastfetch/config.jsonc

# Vérifier les paquets AUR installés
yay -Qm
Personnalisation
# Reconfigurer Starship
starship preset pastel-powerline -o ~/.config/starship.toml

# Modifier la configuration Kitty
nano ~/.config/kitty/kitty.conf

# Personnaliser Fastfetch
nano ~/.config/fastfetch/config.jsonc

🆘 Dépannage
Problèmes courants
❌ Erreur : "Ce script ne doit pas être exécuté en tant que root"
# Solution : Utiliser votre compte utilisateur normal
exit  # Sortir de root
./endeavour_unified_setup.sh
❌ Pilotes NVIDIA non détectés
# Vérifier la carte graphique
lspci | grep -i nvidia

# Réinstaller manuellement
sudo pacman -S nvidia-dkms nvidia-utils nvidia-settings
❌ Disques BTRFS non détectés
# Vérifier manuellement
sudo blkid | grep btrfs
lsblk -f | grep btrfs
❌ Wayland ne fonctionne pas avec NVIDIA
# Vérifier les modules kernel
lsmod | grep nvidia

# Ajouter les options NVIDIA
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
sudo mkinitcpio -P
❌ zsh/Starship non défini par défaut
# Changer le shell manuellement
chsh -s $(which zsh)

# Redémarrer la session
exit
Support et bugs

📖 Wiki : Documentation complète
🐛 Issues : Signaler un bug
💬 Discussions : Forum de la communauté


🤝 Contribution
Comment contribuer

Fork le projet
Créer une branche (git checkout -b feature/ma-nouvelle-fonctionnalité)
Commit vos changements (git commit -m 'Ajout de X')
Push (git push origin feature/ma-nouvelle-fonctionnalité)
Ouvrir une Pull Request

Guidelines de contribution

📝 Code propre et commenté
🧪 Tests avant soumission (sur une VM ou machine dédiée)
📚 Documentation des nouvelles fonctionnalités
🎨 Respect du style existant (couleurs, emojis, structure)

Structure du projet
endeavour-unified-setup/
├── endeavour_unified_setup.sh    # Script principal
├── README.md                     # Documentation (ce fichier)
├── LICENSE                       # Licence MIT
├── docs/                         # Documentation détaillée
│   ├── INSTALLATION.md           # Guide d'installation
│   ├── GAMING.md                 # Guide gaming
│   ├── AI.md                     # Guide AI/ML
│   ├── BTRFS.md                  # Guide BTRFS
│   └── WAYLAND.md                # Guide Wayland
└── screenshots/                  # Captures d'écran
    ├── menu.png
    ├── terminal.png
    ├── fastfetch.png
    └── gaming.png

📄 Licence
Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

🙏 Remerciements

EndeavourOS Team - Pour cette distribution incroyable
Arch Linux Community - Pour l'écosystème et les paquets
Oh My Zsh - Framework zsh fantastique
Starship - Prompt moderne et personnalisable
Kitty - Terminal rapide et configurable
MangoHud - Overlay de performance pour le gaming
Ollama - Pour les modèles LLM locaux


📊 Statistiques
<img src="https://img.shields.io/github/stars/costamorica/endeavour-unified-setup?style=social" alt="GitHub stars" />
<img src="https://img.shields.io/github/forks/costamorica/endeavour-unified-setup?style=social" alt="GitHub forks" />
<img src="https://img.shields.io/github/issues/costamorica/endeavour-unified-setup" alt="GitHub issues" />
<img src="https://img.shields.io/github/last-commit/costamorica/endeavour-unified-setup" alt="GitHub last commit" />

<div align="center">

⭐ Si ce projet vous a aidé, n'hésitez pas à lui donner une étoile ! ⭐
Made with ❤️ for the EndeavourOS and Arch Linux communities
</div>
