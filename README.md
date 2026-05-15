🚀 EndeavourOS Unified Setup 2026
Script tout-en-un pour EndeavourOS - Post-installation, Gaming, AI, Terminal moderne, BTRFS et Wayland

<img src="https://img.shields.io/badge/Version-3.1.0-blue?style=for-the-badge" alt="Version" />
<img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT" />
<img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell: Bash" />
<img src="https://img.shields.io/badge/EndeavourOS-Compatible-7F5AB6?style=for-the-badge&logo=linux&logoColor=white" alt="EndeavourOS" />
<img src="https://img.shields.io/badge/Wayland-Supported-0078D4?style=for-the-badge&logo=wayland&logoColor=white" alt="Wayland" />

---

## 📋 Aperçu rapide

Ce script transforme votre installation fraîche d'EndeavourOS en un environnement complet et optimisé :

🎯 **Installation complète** : Post-installation, pilotes, outils système
🎮 **Gaming ready** : Steam, Proton, MangoHud, GameMode
🤖 **AI & ML** : PyTorch, Ollama, Stable Diffusion
💻 **Terminal moderne** : Kitty, Zsh, Starship, Fastfetch
💾 **BTRFS intelligent** : Détection auto, optimisation, snapshots
🔧 **Multi-machines** : Configuration adaptable selon votre matériel

## 🚀 Démarrage rapide

Après l'installation complète :

1. **Redémarrez** votre système pour appliquer tous les changements
2. **Ouvrez Kitty** comme terminal par défaut (recherche "Kitty")
3. **Lancez Fastfetch** pour voir votre système : `fastfetch`
4. **Configurez Steam** : clic droit sur un jeu → Propriétés → Options de lancement → `mangohud gamemoderun %command%`
5. **Pour l'IA** : `ollama pull llama3` puis `ollama run llama3`

---

## 📋 Table des matières

- [✨ Nouveautés 2026](#-nouveautés-2026)
- [🎯 Fonctionnalités](#-fonctionnalités)
- [📥 Installation](#-installation)
- [📦 Ce qui est installé](#-ce-qui-est-installé)
- [🖥️ Configuration terminal](#️-configuration-terminal)
- [🎮 Setup gaming](#-setup-gaming)
- [🤖 AI & Machine Learning](#-ai--machine-learning)
- [💾 Gestion BTRFS](#-gestion-btrfs)
- [🔧 Optimisations système](#-optimisations-système)
- [📸 Captures d'écran](#-captures-décran)
- [🔧 Utilisation avancée](#-utilisation-avancée)
- [🆘 Dépannage](#-dépannage)
- [🤝 Contribution](#-contribution)
- [📄 Licence](#-licence)


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
Compatibilité multi-machines avec configuration personnalisable

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

## Prérequis

Avant de commencer, assurez-vous d'avoir :

- ✅ **Système d'exploitation** : EndeavourOS ou Arch Linux fraîchement installé
- ✅ **Connexion Internet** : Une connexion stable pour télécharger les paquets
- ✅ **Privilèges** : Compte utilisateur avec droits `sudo` (pas root)
- ✅ **Espace disque** : Au moins 10 Go d'espace libre
- ✅ **Temps** : 30-60 minutes selon votre connexion

> **⚠️ Important** : Ce script installe de nombreux paquets. Il est recommandé de faire une sauvegarde avant l'exécution.

## Méthodes d'installation

### 🚀 Installation automatique (Recommandée)

Pour une installation en une seule commande :

```bash
curl -fsSL https://raw.githubusercontent.com/costamorica/endeavour-unified-setup/main/endeavour_unified_setup.sh | bash
```

Cette commande :
1. Télécharge le script depuis GitHub
2. Le rend exécutable
3. Lance l'installation interactive

### 📥 Installation manuelle

Si vous préférez contrôler le processus :

```bash
# 1. Cloner le dépôt
git clone https://github.com/costamorica/endeavour-unified-setup.git

# 2. Aller dans le dossier
cd endeavour-unified-setup

# 3. Rendre le script exécutable
chmod +x endeavour_unified_setup.sh

# 4. Lancer l'installation
./endeavour_unified_setup.sh
```

## 🖥️ Premier lancement

Après l'installation, le script présente un menu interactif :

```
╔══════════════════════════════════════════════════╗
║           MENU PRINCIPAL - ENDEAVOUR OS 2026          ║
╠══════════════════════════════════════════════════╣
║  1. Installation complète 2026                     ║
║  2. Setup gaming 2026                             ║
║  3. Setup terminal 2026                           ║
║  4. Setup AI/ML 2026                              ║
║  5. Configuration BTRFS avancée                   ║
║  6. Mise à jour complète du système               ║
║  7. Installer les pilotes NVIDIA                 ║
║  8. Installer les paquets essentiels             ║
║  9. Installer yay et applications AUR             ║
║ 10. Appliquer les optimisations système           ║
║ 11. Nettoyer le système                           ║
║ 12. Voir le statut final                          ║
║ 13. Détecter les disques BTRFS                    ║
║ 14. Configurer les options de compatibilité       ║
║  0. Quitter                                      ║
╚══════════════════════════════════════════════════╝
```

**Conseil** : Commencez par l'option **1** pour une installation complète, ou choisissez les options selon vos besoins.

## 🔧 Configuration multi-machines

Pour adapter le script à votre matériel :

1. Lancez l'option **14** : "Configurer les options de compatibilité"
2. Répondez aux questions pour sauter certaines installations
3. Un fichier `~/.endeavour_setup_config` sera créé automatiquement

Exemple de configuration :
```bash
SKIP_NVIDIA=true    # Pas de carte NVIDIA
SKIP_GAMING=false   # Besoin du gaming
SKIP_AI=true        # Pas d'IA
SKIP_AUR=false      # Installer les AUR
```

## 📋 Logs et dépannage

Les logs sont automatiquement sauvegardés dans `/tmp/endeavour_unified_setup_YYYYMMDD.log`

Pour consulter les logs en temps réel :
```bash
tail -f /tmp/endeavour_unified_setup_$(date +%Y%m%d).log
```

En cas de problème, consultez la section [Dépannage](#-dépannage) ci-dessous.

📦 Ce qui est installé

Le script installe automatiquement plus de **200 paquets** organisés par catégories :

## 🔨 Outils système essentiels

**Développement & CLI :**
- `base-devel`, `git`, `vim`, `nano`, `wget`, `curl`
- `htop`, `btop`, `tree`, `unzip`, `zip`, `p7zip`
- `rsync`, `openssh`, `bash-completion`

**Système & Performance :**
- `earlyoom`, `tlp`, `reflector`, `pacman-contrib`
- `pipewire`, `wireplumber`, `pavucontrol`
- `fwupd`, `thermald`, `preload`

## 🎵 Multimédia & Codecs

- `ffmpeg`, `gstreamer` (plugins good/bad/ugly)
- `gst-libav`, `libdvdcss`, `x264`, `x265`
- `lame`, `aom`, `dav1d`, `libva-mesa-driver`

## 🎨 Polices & Thèmes

**Polices système :**
- `ttf-liberation`, `ttf-dejavu`, `noto-fonts`
- `noto-fonts-emoji`, `noto-fonts-cjk`

**Polices développeur (Nerd Fonts) :**
- `ttf-jetbrains-mono-nerd`, `ttf-firacode-nerd`
- `nerd-fonts-complete`, `ttf-meslo-nerd`

## 📱 Applications bureautiques

**Essentielles :**
- `firefox`, `vlc`, `libreoffice-fresh`
- `gimp`, `thunderbird`, `gparted`

**Via AUR :**
- `google-chrome`, `visual-studio-code-bin`
- `discord`, `spotify`, `zoom`

## 🎮 Gaming complet

**Launchers & Jeux :**
- `steam`, `lutris`, `heroic-games-launcher-bin`
- `bottles`, `mangohud`, `gamemode`

**Wine & Proton :**
- `wine-staging`, `winetricks`, `protonup-qt`
- `dxvk-bin`, `vkd3d-proton-bin`

**Graphismes :**
- `lib32-vulkan-icd-loader`, `vulkan-icd-loader`
- `lib32-mesa`, `mesa`, `vulkan-tools`

## ⚡ Outils modernes (CLI)

**Navigation & Recherche :**
- `eza` (remplace `ls`), `bat` (remplace `cat`)
- `fd` (remplace `find`), `ripgrep` (remplace `grep`)
- `fzf`, `zoxide` (remplace `cd`)

**Terminal & Shell :**
- `kitty`, `zsh`, `oh-my-zsh-git`
- `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `starship`, `fastfetch`

## 🤖 AI & Machine Learning

**Frameworks Python :**
- `python-pytorch`, `python-tensorflow`
- `python-scikit-learn`, `python-pandas`
- `python-numpy`, `python-matplotlib`

**Outils IA :**
- `jupyterlab`, `ollama`, `stable-diffusion-webui`
- `python-transformers`, `python-diffusers`

🖥️ Configuration terminal

Le script configure un environnement terminal moderne et productif.

## 🐱 Kitty (Terminal émulé)

**Thème Cyberpunk :**
- Couleurs : Bleu électrique (#00aaff) et cyan
- Transparence : 90% (configurable)
- Police : JetBrains Mono Nerd Font (12pt)

**Raccourcis clavier :**
- `Ctrl+Shift+T` → Nouvel onglet
- `Ctrl+Shift+W` → Fermer l'onglet
- `Ctrl+Shift+F` → Plein écran
- `Ctrl+Shift+→/←` → Onglet suivant/précédent

**Configuration :** `~/.config/kitty/kitty.conf`

## 🐚 Zsh + Starship

**Shell moderne :**
- Zsh avec Oh My Zsh
- Plugins : autosuggestions, syntax-highlighting
- Prompt Starship (thème pastel-powerline)

**Fonctionnalités :**
- Suggestions intelligentes (flèches)
- Coloration syntaxique
- Double `Esc` pour ajouter `sudo`
- Intégration Git (branches, status)

**Aliases pratiques :**
```bash
alias ll='eza -la --icons --group-directories-first'
alias cat='bat --paging=never'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
```

## 🚀 Fastfetch

**Configuration personnalisée :**
- Logo EndeavourOS coloré
- Sections organisées : Système, Hardware, Interface
- Affichage : Kernel, GPU, RAM, paquets installés

**Fichier :** `~/.config/fastfetch/config.jsonc`


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

## Options du menu principal

Le script offre 14 options pour une personnalisation fine :

| Option | Description | Durée estimée | Usage |
|--------|-------------|---------------|-------|
| **1** | Installation complète | 30-60 min | Tout installer automatiquement |
| **2** | Setup gaming | 15-30 min | Gaming + optimisations |
| **3** | Setup terminal | 10-15 min | Terminal moderne uniquement |
| **4** | Setup AI/ML | 20-40 min | Outils d'intelligence artificielle |
| **5** | Configuration BTRFS | 5-10 min | Gestion avancée des disques |
| **6** | Mise à jour système | 10-20 min | Post-installation basique |
| **7** | Pilotes NVIDIA | 5-10 min | Installation pilotes graphiques |
| **8** | Paquets essentiels | 10-15 min | Outils système de base |
| **9** | Yay + AUR | 15-30 min | Gestionnaire AUR + applications |
| **10** | Optimisations | 5 min | Performance système |
| **11** | Nettoyage | 2 min | Libérer de l'espace |
| **12** | Statut final | 1 min | Voir le résumé |
| **13** | Détection BTRFS | 1 min | Lister les disques |
| **14** | Config multi-machines | 2-5 min | Adapter à votre matériel |

## Configuration personnalisée

### Fichier de config

Créez `~/.endeavour_setup_config` pour personnaliser :

```bash
# Exemple de configuration
SKIP_NVIDIA=true    # Sauter les pilotes NVIDIA
SKIP_GAMING=false   # Installer le gaming
SKIP_AI=true        # Sauter l'IA
SKIP_AUR=false      # Installer les AUR
```

### Variables d'environnement

Le script configure automatiquement :

```bash
# Gaming
export MANGOHUD_CONFIG=fps,frametime,gpu_name,cpu_temp,gpu_temp
export GAMEMODED_AUTO=true

# Graphismes
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv_shader_cache"

# Wayland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
```

## Logs et débogage

### Consulter les logs

```bash
# Logs en temps réel
tail -f /tmp/endeavour_unified_setup_$(date +%Y%m%d).log

# Voir les erreurs
grep "ERROR" /tmp/endeavour_unified_setup_*.log
```

### Vérifications post-installation

```bash
# Statut des services
systemctl --user status pipewire
systemctl status gamemoded

# Test du terminal
fastfetch
starship --version

# Test gaming
mangohud --version
gamemoded -t
```

### Reconfiguration

```bash
# Reconfigurer Starship
starship preset pastel-powerline -o ~/.config/starship.toml

# Recharger la config Zsh
exec zsh

# Test des raccourcis Kitty
# Ouvrir ~/.config/kitty/kitty.conf
```


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

Configuration multi-machines
# Créer un fichier de configuration personnalisé
~/.endeavour_setup_config

# Exemple de contenu
SKIP_NVIDIA=true
SKIP_GAMING=false
SKIP_AI=true
SKIP_AUR=false

# Charger la configuration automatiquement
# Le script charge automatiquement ~/.endeavour_setup_config si présent

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


## 🤝 Contribution

Les contributions sont les bienvenues ! 🎉

### Comment contribuer

1. **Fork** le projet
2. **Créez** une branche (`git checkout -b feature/AmazingFeature`)
3. **Committez** vos changements (`git commit -m 'Add some AmazingFeature'`)
4. **Poussez** vers la branche (`git push origin feature/AmazingFeature`)
5. **Ouvrez** une Pull Request

### Guidelines

✅ **Code** : Respecter le style Bash existant
✅ **Tests** : Tester sur une VM avant soumission
✅ **Documentation** : Mettre à jour le README si nécessaire
✅ **Commits** : Messages clairs et descriptifs

### Types de contributions

🐛 **Bug fixes** : Corrections de bugs
✨ **Features** : Nouvelles fonctionnalités
📚 **Documentation** : Améliorations de la doc
🎨 **UI/UX** : Améliorations de l'interface
🔧 **Maintenance** : Nettoyage du code

---

## 🌟 Support & Communauté

### Obtenir de l'aide

- 📧 **Issues GitHub** : Pour les bugs et demandes de fonctionnalités
- 💬 **Discussions GitHub** : Pour les questions générales
- 🐛 **Dépannage** : Consultez la section [Dépannage](#-dépannage)

### Signaler un bug

Pour signaler un bug efficacement :

1. **Vérifiez** qu'il n'existe pas déjà (issues)
2. **Fournissez** les logs : `/tmp/endeavour_unified_setup_*.log`
3. **Indiquez** votre matériel : `inxi -F` ou `neofetch`
4. **Décrivez** les étapes pour reproduire

### Remerciements

Un grand merci à la communauté EndeavourOS et Arch Linux pour leur excellent travail ! 🙏

---

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

## 📊 Statistiques

<img src="https://img.shields.io/github/stars/costamorica/endeavour-unified-setup?style=social" alt="GitHub stars" />
<img src="https://img.shields.io/github/forks/costamorica/endeavour-unified-setup?style=social" alt="GitHub forks" />
<img src="https://img.shields.io/github/issues/costamorica/endeavour-unified-setup" alt="GitHub issues" />
<img src="https://img.shields.io/github/last-commit/costamorica/endeavour-unified-setup" alt="GitHub last commit" />

<div align="center">

⭐ Si ce projet vous a aidé, n'hésitez pas à lui donner une étoile ! ⭐
Made with ❤️ for the EndeavourOS and Arch Linux communities
</div>
