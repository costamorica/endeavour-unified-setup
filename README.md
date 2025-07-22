# 🚀 EndeavourOS Unified Setup

> **Script de configuration complète pour EndeavourOS** - Post-installation, Gaming, Terminal moderne, et gestion automatique des disques BTRFS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![EndeavourOS](https://img.shields.io/badge/EndeavourOS-Compatible-purple.svg)](https://endeavouros.com/)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-Compatible-cyan.svg)](https://archlinux.org/)

## 📋 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [🎯 Installation rapide](#-installation-rapide)
- [📦 Ce qui est installé](#-ce-qui-est-installé)
- [🖥️ Configuration terminal](#️-configuration-terminal)
- [🎮 Setup gaming](#-setup-gaming)
- [💾 Gestion BTRFS](#-gestion-btrfs)
- [📸 Captures d'écran](#-captures-décran)
- [🔧 Utilisation avancée](#-utilisation-avancée)
- [🆘 Dépannage](#-dépannage)
- [🤝 Contribution](#-contribution)

## ✨ Fonctionnalités

### 🔥 **Installation complète en un clic**
- Post-installation système complète
- Configuration gaming avancée
- Terminal moderne avec thème personnalisé
- Détection et configuration automatique des disques BTRFS

### 🎨 **Interface utilisateur moderne**
- Menu interactif coloré et intuitif
- Logs détaillés en temps réel
- Gestion d'erreurs intelligente
- Affichage du statut et des résultats

### 💾 **Gestion BTRFS intelligente**
- **Détection automatique** de tous les disques BTRFS
- Configuration optimisée avec compression Zstandard
- Points de montage automatiques dans `/mnt/`
- Liens symboliques dans le répertoire utilisateur
- Optimisation et défragmentation en arrière-plan

### 🎮 **Gaming-ready**
- Steam, Lutris, Heroic Game Launcher
- MangoHud (overlay de performance)
- GameMode (optimisation automatique)
- Support manettes avancé
- Pilotes NVIDIA automatiques

### 💻 **Terminal de nouvelle génération**
- Kitty avec thème bleu cyan transparent
- zsh + Oh My Zsh + Powerlevel10k
- Fastfetch avec configuration personnalisée
- Outils modernes (exa, bat, fd, fzf)

## 🎯 Installation rapide

### Prérequis

- EndeavourOS ou Arch Linux fraîchement installé
- Connexion Internet active
- Compte utilisateur non-root avec droits sudo

### Installation en une ligne

```bash
# Téléchargement et exécution
curl -fsSL https://raw.githubusercontent.com/costamorica/endeavour-unified-setup/main/endeavour_unified_setup.sh | bash
```

### Installation manuelle

```bash
# Clonage du dépôt
git clone https://github.com/costamorica/endeavour-unified-setup.git
cd endeavour-unified-setup

# Rendre exécutable
chmod +x endeavour_unified_setup.sh

# Lancer l'installation
./endeavour_unified_setup.sh
```

## 📦 Ce qui est installé

### 🔨 **Outils de développement**
```
base-devel, git, vim, nano, wget, curl, htop, tree, unzip, zip, p7zip, rsync, openssh, bash-completion
```

### 🎵 **Multimédia**
```
ffmpeg, codecs gstreamer, libdvdcss, x264, x265, lame
```

### 🎨 **Polices**
```
ttf-liberation, ttf-dejavu, noto-fonts, nerd-fonts, adobe-source-code-pro
```

### 📱 **Applications**
```
firefox, vlc, libreoffice, gimp, thunderbird, gparted, bleachbit, timeshift
google-chrome, vscode, discord, spotify (via AUR)
```

### 🎮 **Gaming**
```
steam, lutris, heroic-games-launcher, mangohud, gamemode, wine, protonup-qt
```

### ⚡ **Outils modernes**
```
exa, bat, fd, ripgrep, fzf, neofetch, fastfetch
```

## 🖥️ Configuration terminal

### Kitty
- **Thème** : Bleu cyan avec transparence
- **Police** : JetBrains Mono Nerd Font
- **Raccourcis** : Copier/coller optimisés
- **Onglets** : Style powerline avec couleurs personnalisées

### zsh + Oh My Zsh
- **Thème** : Powerlevel10k personnalisé
- **Plugins** : autosuggestions, syntax-highlighting, git
- **Aliases** : Commands système et git optimisés

### Fastfetch
- Configuration personnalisée avec sections organisées
- Logo EndeavourOS avec couleurs cyan/bleu
- Affichage système, hardware, interface, réseau

## 🎮 Setup gaming

### Outils installés
- **Steam** : Client gaming principal
- **Lutris** : Gestionnaire multi-plateformes
- **Heroic** : Client Epic Games/GOG
- **MangoHud** : Overlay de performance
- **GameMode** : Optimisations automatiques
- **ProtonUp-Qt** : Gestionnaire Proton-GE

### Configuration MangoHud
```bash
# Dans Steam, options de lancement des jeux :
mangohud gamemoderun %command%
```

### Optimisations système
- `vm.max_map_count` optimisé pour les jeux
- Variables d'environnement Wine/Proton
- Désactivation du watchdog système

## 💾 Gestion BTRFS

### Détection automatique
Le script détecte automatiquement :
- Disques entiers formatés en BTRFS
- Partitions BTRFS sur tous les périphériques
- Types de périphériques : `/dev/sd*`, `/dev/nvme*`

### Points de montage intelligents
```
/dev/sda  → /mnt/nas    → ~/nas
/dev/sdb  → /mnt/games  → ~/games  
/dev/sdc  → /mnt/data   → ~/data
Label détecté → /mnt/label → ~/label
```

### Options BTRFS optimisées
```
defaults,user,rw,exec,auto,noatime,space_cache=v2,compress=zstd:3
```

### Fonctionnalités avancées
- Défragmentation automatique avec compression
- Optimisation en arrière-plan
- Gestion des sous-volumes
- Sauvegarde automatique de la configuration

## 📸 Captures d'écran

### Menu principal
```
╔══════════════════════════════════════════════════════════╗
║              ENDEAVOUR OS - SETUP UNIFIÉ                ║
║    Post-install • Gaming • Terminal • Disques BTRFS     ║
║                 Version: 2.0.0                          ║
╚══════════════════════════════════════════════════════════╝

Disques BTRFS détectés:
[1] /dev/sda1
    UUID: 12345678-1234-5678-9abc-def012345678
    Label: NAS
    Taille: 2T
    Status: Non monté

═══════════════════════════════════════════════════════════
                    MENU PRINCIPAL                         
═══════════════════════════════════════════════════════════

Configurations complètes :
  1) 🚀 Installation COMPLÈTE (tout en un)
  2) 🎮 Setup GAMING complet  
  3) 💻 Setup TERMINAL complet (Kitty + zsh)

Modules individuels :
  4) 📦 Post-installation système
  5) 💾 Configuration disques BTRFS
  ...
```

### Terminal configuré
- Prompt Powerlevel10k avec icônes et couleurs
- Fastfetch au démarrage avec informations système
- Transparence et blur activés
- Thème cohérent bleu cyan

## 🔧 Utilisation avancée

### Options de menu

| Option | Description | Durée estimée |
|--------|-------------|---------------|
| 1 | Installation complète | 30-60 min |
| 2 | Setup gaming | 15-30 min |
| 3 | Setup terminal | 10-15 min |
| 4 | Post-installation | 10-20 min |
| 5 | Configuration BTRFS | 5-10 min |

### Logs et débogage

```bash
# Consulter les logs
tail -f /tmp/endeavour_unified_setup.log

# Vérifier le statut des montages
df -h | grep btrfs

# Tester la configuration terminal
fastfetch --config ~/.config/fastfetch/config.jsonc
```

### Personnalisation

```bash
# Reconfigurer Powerlevel10k
p10k configure

# Modifier la configuration Kitty
nano ~/.config/kitty/kitty.conf

# Personnaliser Fastfetch
nano ~/.config/fastfetch/config.jsonc
```

## 🆘 Dépannage

### Problèmes courants

#### ❌ **Erreur : "Ce script ne doit pas être exécuté en tant que root"**
```bash
# Solution : Utiliser votre compte utilisateur normal
exit  # Sortir de root
./endeavour_unified_setup.sh
```

#### ❌ **Pilotes NVIDIA non détectés**
```bash
# Vérifier la carte graphique
lspci | grep -i nvidia
# Réinstaller manuellement si nécessaire
sudo pacman -S nvidia nvidia-utils
```

#### ❌ **Disques BTRFS non détectés**
```bash
# Vérifier manuellement
sudo blkid | grep btrfs
lsblk -f
```

#### ❌ **zsh non défini par défaut**
```bash
# Changer le shell manuellement
chsh -s $(which zsh)
# Redémarrer la session
```

### Support et bugs

- 📖 **Wiki** : [Voir la documentation complète](https://github.com/costamorica/endeavour-unified-setup/wiki)
- 🐛 **Issues** : [Signaler un bug](https://github.com/costamorica/endeavour-unified-setup/issues)
- 💬 **Discussions** : [Forum de la communauté](https://github.com/costamorica/endeavour-unified-setup/discussions)

## 🤝 Contribution

### Comment contribuer

1. **Fork** le projet
2. Créer une **branche** pour votre fonctionnalité (`git checkout -b feature/amazing-feature`)
3. **Commit** vos changements (`git commit -m 'Add amazing feature'`)
4. **Push** sur la branche (`git push origin feature/amazing-feature`)
5. Ouvrir une **Pull Request**

### Guidelines de contribution

- 📝 Code propre et commenté
- 🧪 Tests avant soumission
- 📚 Documentation des nouvelles fonctionnalités
- 🎨 Respect du style existant

### Structure du projet

```
endeavour-unified-setup/
├── endeavour_unified_setup.sh    # Script principal
├── README.md                     # Cette documentation
├── LICENSE                       # Licence MIT
├── docs/                        # Documentation détaillée
│   ├── INSTALLATION.md
│   ├── GAMING.md
│   └── BTRFS.md
└── screenshots/                 # Captures d'écran
    ├── menu.png
    ├── terminal.png
    └── fastfetch.png
```

## 📄 Licence

Ce projet est sous licence **MIT** - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🙏 Remerciements

- **EndeavourOS Team** - Pour cette excellente distribution
- **Arch Linux Community** - Pour l'écosystème et les paquets
- **Oh My Zsh** - Framework zsh fantastique  
- **Powerlevel10k** - Thème de prompt moderne
- **Kitty** - Terminal rapide et configurable

## 📊 Statistiques

![GitHub stars](https://img.shields.io/github/stars/costamorica/endeavour-unified-setup?style=social)
![GitHub forks](https://img.shields.io/github/forks/costamorica/endeavour-unified-setup?style=social)
![GitHub issues](https://img.shields.io/github/issues/costamorica/endeavour-unified-setup)
![GitHub last commit](https://img.shields.io/github/last-commit/costamorica/endeavour-unified-setup)

---

<div align="center">

**⭐ Si ce projet vous a aidé, n'hésitez pas à lui donner une étoile ! ⭐**

Made with ❤️ for the EndeavourOS community

</div>
