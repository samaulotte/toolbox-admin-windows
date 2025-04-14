<h1 align="center">🛠️ Toolbox Admin - Windows</h1>

<p align="center">
  Script Batch interactif pour les administrateurs systèmes sous Windows.<br>
  Gestion, configuration, diagnostic, maintenance — tout en un.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/windows-10%2F11-blue?logo=windows" alt="Windows">
  <img src="https://img.shields.io/badge/powershell-compatible-lightgrey?logo=powershell" alt="PowerShell Compatible">
  <img src="https://img.shields.io/github/license/ton-utilisateur/toolbox-admin-windows" alt="License">
  <img src="https://img.shields.io/badge/status-maintained-brightgreen" alt="Maintained">
</p>

---

## 📚 Sommaire

- [🎯 Objectif](#-objectif)
- [🧰 Fonctionnalités](#-fonctionnalités)
- [🖥️ Aperçu visuel](#️-aperçu-visuel)
- [🚀 Installation & utilisation](#-installation--utilisation)
- [🗂️ Structure du projet](#️-structure-du-projet)
- [📄 Licence](#-licence)
- [📬 Contact](#-contact)

---

## 🎯 Objectif

**Toolbox Admin** est un utilitaire batch tout-en-un conçu pour les admins système.  
Il centralise les tâches d’administration classiques (réseau, utilisateurs, maintenance) dans une interface console intuitive, sans dépendance externe.

---

## 🧰 Fonctionnalités

### 👥 Gestion utilisateurs & groupes
- Ajouter / supprimer des utilisateurs et groupes locaux
- Gérer les appartenances aux groupes
- Désactiver l’expiration des mots de passe

### 🌐 Outils réseau
- Affecter une IP statique ou activer DHCP
- Configurer ou réinitialiser les DNS
- Activer/désactiver le Wi-Fi
- Voir connexions réseau, tester connectivité (ping, DNS)

### 💾 Sauvegarde de dossiers
- Sauvegarde manuelle ou en ligne de commande
- Nommage automatique par date
- Attribution des droits d’accès

### 🧼 Maintenance système
- Outils SFC, DISM, chkdsk
- Nettoyage disque (`cleanmgr`)
- Réinitialisation IP/Winsock, Windows Update
- Journalisation et inspection système (erreurs, services, disques)

---

## 🖥️ Aperçu visuel

```text
╔════════════════════════════════════════════════════╗
║                      TOOLBOX                       ║
╚════════════════════════════════════════════════════╝

  [1] Gestion des utilisateurs et groupes
  [2] Configuration réseau
  [3] Divers (partage, connectivité)
  [4] Backup d'un dossier
  [5] Entretien du PC
  [0] Quitter
