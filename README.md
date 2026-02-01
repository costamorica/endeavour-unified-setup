🚀 EndeavourOS Unified Setup 2026
Script tout-en-un pour EndeavourOS (Arch Linux) - Post-installation, Gaming, AI, Terminal, BTRFS, Wayland
<img src="https://img.shields.io/badge/Version-3.0.0-blue?style=for-the-badge" alt="Version" />
<img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
<img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux" />
<img src="https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash" />

📌 Table des matières

✨ Nouveautés 2026
🛠️ Fonctionnalités
📥 Installation
🖥️ Utilisation
🎮 Gaming (Optimisations 2026)
🤖 AI & Machine Learning
💻 Terminal & Productivité
🗃️ Gestion des disques BTRFS
🔧 Optimisations système
📸 Captures d'écran
📜 Journal des modifications
🤝 Contribution
📄 Licence


✨ Nouveautés 2026
Copier le tableau


Fonctionnalité
Description



🚀 Wayland natif
Support complet pour Wayland avec NVIDIA et optimisations


🤖 AI/ML Tools
Installation de PyTorch, TensorFlow, Ollama, Stable Diffusion


🎮 Gaming 2026
Proton-GE, DXVK, VKD3D-Proton, MangoHud, GameMode


💻 Terminal moderne
Starship, Zoxide, Eza, Bat, Kitty avec thème cyberpunk


🗃️ BTRFS optimisé
discard=async, zstd:3, équilibrage automatique


🔧 Optimisations système
EarlyOOM, TLP, Kernel 6.8+, PipeWire, NVIDIA 550+


📦 AUR avancé
Installation automatique de 100+ paquets AUR (yay)


🧹 Nettoyage intelligent
Suppression des anciens kernels, cache, journaux



🛠️ Fonctionnalités
🔹 Post-installation complète
✅ Mise à jour du système (Kernel 6.8+)
✅ Installation des pilotes NVIDIA/AMD
✅ Configuration de PipeWire (audio moderne)
✅ Installation des paquets essentiels (150+)
✅ Configuration de yay (AUR helper)
🔹 Gaming optimisé
✅ Installation de Steam, Lutris, Heroic, Bottles
✅ Configuration de Proton-GE, DXVK, VKD3D-Proton
✅ Optimisations pour NVIDIA (CoolBits, DLSS, ReBar)
✅ MangoHud + GameMode pour les performances
✅ Support des contrôleurs (SDL2, XInput, Wayland)
🔹 AI & Machine Learning
✅ PyTorch, TensorFlow, JupyterLab
✅ Ollama (modèles Llama3, Mistral, Phi-3)
✅ Stable Diffusion + ComfyUI
✅ CUDA & ROCm (pour NVIDIA/AMD)
🔹 Terminal & Productivité
✅ Kitty (terminal moderne)
✅ Zsh + Oh My Zsh + Starship
✅ Nerd Fonts (JetBrains Mono, Fira Code, Meslo)
✅ Fastfetch (alternative à Neofetch)
✅ Zoxide, Eza, Bat, Ripgrep, Fzf
🔹 Gestion des disques BTRFS
✅ Détection automatique des disques BTRFS
✅ Configuration intelligente (discard=async, zstd:3)
✅ Création de liens symboliques (~/Storage/)
✅ Optimisation des filesystems (défragmentation, équilibrage)
🔹 Optimisations système
✅ EarlyOOM (prévention des freezes)
✅ TLP (gestion de l'énergie)
✅ Kernel optimisé (6.8+)
✅ Variables d'environnement gaming
✅ Nettoyage automatique (anciens kernels, cache)

📥 Installation
1️⃣ Téléchargement
git clone https://github.com/votre-utilisateur/endeavour-unified-setup.git
cd endeavour-unified-setup
chmod +x endeavour_unified_setup.sh
2️⃣ Exécution
./endeavour_unified_setup.sh
(Le script détectera automatiquement votre session Wayland/X11 et s'adaptera.)

🖥️ Utilisation
🔹 Menu principal
 (Exemple d'interface)
Copier le tableau


Option
Description



1
Installation complète (tout en un)


2
Setup gaming optimisé


3
Configuration du terminal moderne


4
Installation des outils AI/ML


5
Configuration avancée BTRFS


6
Mise à jour du système


7
Installation des pilotes NVIDIA


8
Installation des paquets essentiels


9
Installation de yay + AUR


10
Optimisations système


11
Nettoyage du système


12
Statut final


13
Détection des disques BTRFS


0
Quitter


🔹 Exemple : Installation complète
./endeavour_unified_setup.sh
# Sélectionnez l'option 1
(Le script installera tout automatiquement et vous proposera un redémarrage.)

🎮 Gaming (Optimisations 2026)
🔹 Configuration recommandée pour Steam

Ouvrez Steam → Paramètres → Steam Play
Activez :
✅ Activer Steam Play pour tous les titres
✅ Utiliser Proton Experimental


Pour chaque jeu :
Clic droit → Propriétés → Options de lancement
Ajoutez :mangohud gamemoderun %command%

(Pour Vulkan : vkbasalt %command%)



🔹 Outils installés
Copier le tableau


Outil
Description



Proton-GE
Version améliorée de Proton (meilleure compatibilité)


DXVK
Traduction DirectX → Vulkan (meilleures performances)


VKD3D-Proton
Traduction DirectX 12 → Vulkan


MangoHud
Overlay FPS, température, utilisation GPU


GameMode
Optimisation des performances en jeu


Heroic Games Launcher
Alternative à Epic Games Store


Bottles
Gestion des préfixes Wine



🤖 AI & Machine Learning
🔹 Outils installés
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


🔹 Utilisation d'Ollama
ollama pull llama3  # Télécharge le modèle Llama3
ollama run llama3   # Lance une session interactive
(Modèles disponibles : llama3, mistral, phi3, gemma)

💻 Terminal & Productivité
🔹 Configuration de Kitty

Thème : Cyberpunk (bleu électrique)
Police : JetBrains Mono Nerd Font
Transparence : 90% (réglable)
Raccourcis :
Ctrl+Shift+T → Nouvel onglet
Ctrl+Shift+W → Fermer l'onglet
Ctrl+Shift+F → Plein écran



🔹 Configuration de Starship
# Personnalisation (exemple)
starship preset pastel-powerline -o ~/.config/starship.toml
(Thèmes disponibles : pastel-powerline, nerd-font-symbols, tokyo-night)
🔹 Outils installés
Copier le tableau


Outil
Description



Zoxide
Navigation intelligente (z pour aller dans un dossier)


Eza
Alternative moderne à ls (couleurs, icônes)


Bat
Alternative à cat (syntaxe highlight)


Ripgrep
Recherche ultra-rapide (rg)


Fzf
Recherche floue (Ctrl+R pour l'historique)



🗃️ Gestion des disques BTRFS
🔹 Détection automatique
Le script détecte automatiquement les disques BTRFS et propose :

Montage automatique (/mnt/ssd_data, /mnt/hdd_games, etc.)
Optimisation (discard=async, zstd:3, space_cache=v2)
Création de liens symboliques (~/Storage/)

🔹 Commandes utiles
Copier le tableau


Commande
Description



sudo btrfs filesystem usage /mnt/ssd_data
Voir l'utilisation du disque


sudo btrfs balance start /mnt/ssd_data
Équilibrer le filesystem


sudo btrfs filesystem defrag -r /mnt/ssd_data
Défragmenter



🔧 Optimisations système
🔹 Optimisations appliquées
Copier le tableau


Optimisation
Description



EarlyOOM
Tue les processus gourmands avant le freeze


TLP
Gestion intelligente de l'énergie (CPU, GPU)


Kernel 6.8+
Dernières optimisations pour le gaming


PipeWire
Audio moderne (remplace PulseAudio)


NVIDIA 550+
Support Wayland, DLSS, ReBar


Variables gaming
__GL_THREADED_OPTIMIZATIONS=1, DXVK_HUD=fps


🔹 Vérification des optimisations
# Vérifier le scheduler disque
cat /sys/block/sda/queue/scheduler

# Vérifier les variables gaming
env | grep -E "WINE|DXVK|__GL"

# Vérifier le kernel
uname -r

📸 Captures d'écran
(Ajoutez des captures d'écran pour illustrer le script en action.)
1️⃣ Menu principal

2️⃣ Fastfetch (alternative à Neofetch)

3️⃣ Terminal Kitty + Starship

4️⃣ Gaming (MangoHud + GameMode)


📜 Journal des modifications
🔹 Version 3.0.0 (Février 2026)
✅ Wayland natif (support complet)
✅ AI/ML Tools (Ollama, PyTorch, Stable Diffusion)
✅ Gaming 2026 (Proton-GE, DXVK, VKD3D-Proton)
✅ Terminal moderne (Starship, Zoxide, Eza, Bat)
✅ BTRFS optimisé (discard=async, zstd:3)
✅ Optimisations système (EarlyOOM, TLP, Kernel 6.8+)
✅ Nettoyage intelligent (anciens kernels, cache)
🔹 Version 2.0.0 (2024)
✅ Post-installation complète
✅ Gaming basique (MangoHud, GameMode)
✅ Terminal (Kitty, Zsh, Powerlevel10k)
✅ BTRFS basique

🤝 Contribution
Vous voulez contribuer ? Voici comment :

Forkez le dépôt
Créez une branche (git checkout -b feature/ma-nouvelle-fonctionnalité)
Committez vos changements (git commit -m "Ajout de X")
Push (git push origin feature/ma-nouvelle-fonctionnalité)
Ouvrez une Pull Request

🔹 Idées d'améliorations

 Ajout d'un mode "Silencieux" (moins de logs)
 Support de Hyprland (Wayland)
 Sauvegarde automatique des configurations
 Interface graphique (GTK/Qt)


📄 Licence
Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

🎉 Merci d'utiliser EndeavourOS Unified Setup 2026 !
Si ce script vous a été utile, n'hésitez pas à :
⭐ L'étoiler sur GitHub
📢 Le partager avec la communauté
💬 Donner votre avis dans les issues
🔗 Lien GitHub : https://github.com/votre-utilisateur/endeavour-unified-setup

📌 Pourquoi ce Markdown est-il moderne ?
✔ Structure claire (Table des matières, sections bien organisées)
✔ Badges (Version, License, OS, Langage)
✔ Captures d'écran (Illustration visuelle)
✔ Tableaux (Comparaisons, commandes utiles)
✔ Code blocks (Exemples de commandes)
✔ Emojis (Meilleure lisibilité)
✔ Journal des modifications (Transparence)
✔ Guide de contribution (Encouragement à la communauté)

🔹 Prochaines étapes pour votre README

Ajoutez des captures d'écran (utilisez Imgur ou GitHub Issues)
Créez un GIF (avec Peek ou ScreenToGif)
Ajoutez des liens vers les outils mentionnés (Ollama, Proton-GE, etc.)
Traduisez-le en anglais (pour toucher plus de monde)
Ajoutez un logo pour le projet

Si vous voulez, je peux vous aider à :

Générer un GIF de démonstration
Créer un logo pour le projet
Traduire le README en anglais
Ajouter des animations CSS (pour GitHub)

Dites-moi ce que vous en pensez ! 🚀
l'ancien readme:
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
Voici une version modernisée et enrichie de votre README.md, intégrant les nouveautés de 2026 tout en conservant la structure claire et pédagogique de l'original. J'ai ajouté des sections manquantes, mis à jour les informations, et amélioré la présentation visuelle.

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
