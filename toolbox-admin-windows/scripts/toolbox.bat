@echo off
chcp 65001 >nul
title Toolbox - Outil de gestion et maintenance
color 09

REM Vérification des droits administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Demande de droits administrateur en cours...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

REM Si des paramètres sont passés (pour la fonction Backup), on les traite directement
if not "%~1"=="" if not "%~2"=="" goto backup

:main_menu
cls
echo ╔════════════════════════════════════════════════════╗
echo ║                      TOOLBOX                       ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo   [1] Gestion des utilisateurs et groupes
echo   [2] Configuration réseau
echo   [3] Divers (partage, connectivité)
echo   [4] Backup d'un dossier
echo   [5] Entretien du PC
echo   [0] Quitter
echo.
set /p choice="Faites votre choix : "

if "%choice%"=="1" goto gestion_utilisateurs
if "%choice%"=="2" goto configuration_reseau
if "%choice%"=="3" goto divers
if "%choice%"=="4" goto backup
if "%choice%"=="5" goto entretien_pc
if "%choice%"=="0" goto quitter

goto main_menu

:gestion_utilisateurs
cls
echo ╔════════════════════════════════════════════════════╗
echo ║   Gestion des utilisateurs et groupes              ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo   [1] Ajouter un utilisateur
echo   [2] Supprimer un utilisateur
echo   [3] Ajouter un groupe
echo   [4] Supprimer un groupe
echo   [5] Ajouter un utilisateur à un groupe
echo   [6] Retirer un utilisateur d'un groupe
echo   [7] Retour
echo   [8] Désactiver l'expiration des mots de passe
echo.
set /p choice="Votre choix : "

if "%choice%"=="1" goto add_user
if "%choice%"=="2" goto delete_user
if "%choice%"=="3" goto add_group
if "%choice%"=="4" goto delete_group
if "%choice%"=="5" goto add_user_to_group
if "%choice%"=="6" goto remove_user_from_group
if "%choice%"=="7" goto main_menu
if "%choice%"=="8" goto disable_password_expiration

goto gestion_utilisateurs

:add_user
cls
echo ╔════════════════════════════════════╗
echo ║   Ajouter un utilisateur           ║
echo ╚════════════════════════════════════╝
echo.
set /p username="Nom de l'utilisateur : "
set /p password="Mot de passe : "
net user %username% %password% /add
echo.
echo Utilisateur %username% ajoute.
pause
goto gestion_utilisateurs

:delete_user
cls
echo ╔════════════════════════════════════╗
echo ║   Supprimer un utilisateur         ║
echo ╚════════════════════════════════════╝
echo.
set /p username="Nom de l'utilisateur : "
net user %username% /delete
echo.
echo Utilisateur %username% supprime.
pause
goto gestion_utilisateurs

:add_group
cls
echo ╔════════════════════════════════════╗
echo ║   Ajouter un groupe                ║
echo ╚════════════════════════════════════╝
echo.
set /p groupname="Nom du groupe : "
net localgroup %groupname% /add
echo.
echo Groupe %groupname% ajoute.
pause
goto gestion_utilisateurs

:delete_group
cls
echo ╔════════════════════════════════════╗
echo ║   Supprimer un groupe              ║
echo ╚════════════════════════════════════╝
echo.
set /p groupname="Nom du groupe : "
net localgroup %groupname% /delete
echo.
echo Groupe %groupname% supprime.
pause
goto gestion_utilisateurs

:add_user_to_group
cls
echo ╔════════════════════════════════════════╗
echo ║   Ajouter un utilisateur à un groupe   ║
echo ╚════════════════════════════════════════╝
echo.
set /p username="Nom de l'utilisateur : "
set /p groupname="Nom du groupe : "
net localgroup %groupname% %username% /add
echo.
echo L'utilisateur %username% a été ajoute au groupe %groupname%.
pause
goto gestion_utilisateurs

:remove_user_from_group
cls
echo ╔════════════════════════════════════════╗
echo ║   Retirer un utilisateur d'un groupe   ║
echo ╚════════════════════════════════════════╝
echo.
set /p username="Nom de l'utilisateur : "
set /p groupname="Nom du groupe : "
net localgroup %groupname% %username% /delete
echo.
echo L'utilisateur %username% a été retire du groupe %groupname%.
pause
goto gestion_utilisateurs

:disable_password_expiration
cls
echo ╔════════════════════════════════════════════╗
echo ║   Désactivation de l'expiration des MDP    ║
echo ╚════════════════════════════════════════════╝
echo.
net accounts /maxpwage:unlimited
echo.
echo Les mots de passe ne vont plus expirer.
pause
goto gestion_utilisateurs

:configuration_reseau
cls
echo ╔════════════════════════════════════════════════════╗
echo ║             Configuration réseau                   ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo   [1] Mettre une adresse IP statique
echo   [2] Activer le DHCP
echo   [3] Afficher la configuration réseau
echo   [4] Test de connectivité (Ping)
echo   [5] Résolution DNS
echo   [6] Voir les connexions réseau
echo   [7] Renouveler l'adresse IP
echo   [8] Modifier les serveurs DNS (Google)
echo   [9] Repasser en DNS automatique
echo  [10] Activer/Désactiver le Wi-Fi
echo  [11] Retour
echo.
set /p choice="Votre choix : "

if "%choice%"=="1" goto set_static_ip
if "%choice%"=="2" goto enable_dhcp
if "%choice%"=="3" goto display_net_config
if "%choice%"=="4" goto test_ping
if "%choice%"=="5" goto dns_resolution
if "%choice%"=="6" goto view_net_connections
if "%choice%"=="7" goto renew_ip
if "%choice%"=="8" goto set_google_dns
if "%choice%"=="9" goto auto_dns
if "%choice%"=="10" goto toggle_wifi
if "%choice%"=="11" goto main_menu

goto configuration_reseau

:set_static_ip
cls
echo ╔════════════════════════════════════╗
echo ║   Adresse IP statique              ║
echo ╚════════════════════════════════════╝
echo.
set /p interface="Nom de l'interface (ex: Ethernet) : "
set /p ip="Adresse IP : "
set /p mask="Masque de sous-réseau : "
set /p gateway="Passerelle : "
netsh interface ip set address name="%interface%" static %ip% %mask% %gateway%
echo.
echo Adresse IP statique configuree sur %interface%.
pause
goto configuration_reseau

:enable_dhcp
cls
echo ╔════════════════════════════════════╗
echo ║       Activer le DHCP              ║
echo ╚════════════════════════════════════╝
echo.
set /p interface="Nom de l'interface (ex: Ethernet) : "
netsh interface ip set address name="%interface%" dhcp
echo.
echo DHCP active sur %interface%.
pause
goto configuration_reseau

:display_net_config
cls
echo ╔════════════════════════════════════╗
echo ║     Configuration réseau           ║
echo ╚════════════════════════════════════╝
echo.
ipconfig /all
pause
goto configuration_reseau

:test_ping
cls
echo ╔════════════════════════════════════╗
echo ║     Test de connectivité (Ping)    ║
echo ╚════════════════════════════════════╝
echo.
set /p target="Adresse (ex: google.com) : "
ping %target%
pause
goto configuration_reseau

:dns_resolution
cls
echo ╔════════════════════════════════════╗
echo ║         Résolution DNS             ║
echo ╚════════════════════════════════════╝
echo.
set /p hostname="Nom d'hôte à résoudre : "
nslookup %hostname%
pause
goto configuration_reseau

:view_net_connections
cls
echo ╔════════════════════════════════════╗
echo ║      Connexions réseau             ║
echo ╚════════════════════════════════════╝
echo.
netstat -an
pause
goto configuration_reseau

:renew_ip
cls
echo ╔════════════════════════════════════╗
echo ║     Renouveler l'adresse IP        ║
echo ╚════════════════════════════════════╝
echo.
ipconfig /renew
pause
goto configuration_reseau

:set_google_dns
cls
echo ╔════════════════════════════════════╗
echo ║   DNS vers Google (8.8.8.8 / 8.8.4.4) ║
echo ╚════════════════════════════════════╝
echo.
set /p interface="Nom de l'interface (ex: Ethernet) : "
netsh interface ip set dns name="%interface%" static 8.8.8.8 primary
netsh interface ip add dns name="%interface%" 8.8.4.4 index=2
echo.
echo Serveurs DNS de %interface% modifies vers Google.
pause
goto configuration_reseau

:auto_dns
cls
echo ╔════════════════════════════════════╗
echo ║     Repasser en DNS automatique    ║
echo ╚════════════════════════════════════╝
echo.
set /p interface="Nom de l'interface (ex: Ethernet) : "
netsh interface ip set dns name="%interface%" dhcp
echo.
echo Serveur DNS configure en automatique sur %interface%.
pause
goto configuration_reseau

:toggle_wifi
cls
echo ╔════════════════════════════════════╗
echo ║   Activer/Désactiver le Wi-Fi      ║
echo ╚════════════════════════════════════╝
echo.
set /p state="Entrez 'on' pour activer ou 'off' pour desactiver : "
if /i "%state%"=="on" (
    netsh interface set interface name="Wi-Fi" admin=enabled
    echo.
    echo Wi-Fi active.
) else if /i "%state%"=="off" (
    netsh interface set interface name="Wi-Fi" admin=disabled
    echo.
    echo Wi-Fi desactive.
) else (
    echo.
    echo Choix invalide.
)
pause
goto configuration_reseau

:divers
cls
echo ╔════════════════════════════════════════════════════╗
echo ║            Divers (partage, connectivité)          ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo   [1] Creation d’un partage complet
echo   [2] Tester la connectivite internet
echo   [3] Retour
echo.
set /p choice="Votre choix : "

if "%choice%"=="1" goto create_share
if "%choice%"=="2" goto test_internet
if "%choice%"=="3" goto main_menu

goto divers

:create_share
cls
echo ╔════════════════════════════════════╗
echo ║   Création d'un partage complet    ║
echo ╚════════════════════════════════════╝
echo.
set /p folder="Chemin du dossier a partager (ex: C:\Partage) : "
md "%folder%"
set /p shareName="Nom du partage : "
net share %shareName%="%folder%" /grant:everyone,full
echo.
echo Dossier %folder% partage sous le nom %shareName%.
pause
goto divers

:test_internet
cls
echo ╔════════════════════════════════════╗
echo ║    Test de connectivité internet   ║
echo ╚════════════════════════════════════╝
echo.
ping google.com
pause
goto divers

:backup
cls
echo ╔════════════════════════════════════╗
echo ║         Backup d'un dossier        ║
echo ╚════════════════════════════════════╝
echo.
REM Si le script est appele avec des parametres, on les utilise
if "%~1"=="" (
    set /p source="Dossier source (ex: C:\MonDossier) : "
    set /p destination="Dossier destination (ex: C:\Sauvegarde) : "
) else (
    set source=%~1
    set destination=%~2
)
REM Recuperation de la date au format YYYYMMDD
for /f "tokens=2 delims==." %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set YYYY=%datetime:~0,4%
set MM=%datetime:~4,2%
set DD=%datetime:~6,2%
set backupFolder=backup_%YYYY%%MM%%DD%
REM Création du dossier de backup
md "%destination%\%backupFolder%"
REM Récupération du nom du dossier source
for %%* in ("%source%") do set folderName=%%~n*
echo.
echo Sauvegarde de "%source%" vers "%destination%\%backupFolder%\%folderName%"
xcopy "%source%" "%destination%\%backupFolder%\%folderName%" /E /I /H /Y
REM Attribution des permissions en full access pour l'utilisateur actuel
icacls "%destination%\%backupFolder%\%folderName%" /grant "%USERNAME%":F /T
echo.
echo Backup termine.
pause
goto main_menu

:entretien_pc
cls
echo ╔════════════════════════════════════════════════════╗
echo ║               Entretien du PC                      ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo   [1] SFC /scannow (vérification/réparation système)
echo   [2] DISM /CheckHealth (vérification image Windows)
echo   [3] DISM /ScanHealth (analyse image Windows)
echo   [4] DISM /RestoreHealth (réparation image Windows)
echo   [5] chkdsk (vérification/réparation disque)
echo   [6] cleanmgr /sagerun:1 (nettoyage avancé)
echo   [7] ipconfig /flushdns (vider le cache DNS)
echo   [8] netsh winsock reset (réinitialisation réseau)
echo   [9] netsh int ip reset (réinitialisation IP)
echo  [10] Afficher les 10 dernières erreurs du journal système
echo  [11] wmic diskdrive get status (état SMART du disque)
echo  [12] tasklist /v (liste des processus)
echo  [13] Trouver les 10 fichiers les plus volumineux
echo  [14] Réinitialiser Windows Update
echo  [15] Ouvrir msconfig
echo  [16] Redémarrer en mode sans échec
echo  [17] Réparer le démarrage de Windows (bootrec)
echo  [18] Retour
echo.
set /p choice="Votre choix : "

if "%choice%"=="1" goto sfc_scan
if "%choice%"=="2" goto dism_checkhealth
if "%choice%"=="3" goto dism_scanhealth
if "%choice%"=="4" goto dism_restorehealth
if "%choice%"=="5" goto chkdsk_repair
if "%choice%"=="6" goto cleanmgr_run
if "%choice%"=="7" goto flush_dns
if "%choice%"=="8" goto reset_winsock
if "%choice%"=="9" goto reset_ip
if "%choice%"=="10" goto show_errors
if "%choice%"=="11" goto check_smart
if "%choice%"=="12" goto list_processes
if "%choice%"=="13" goto find_large_files
if "%choice%"=="14" goto reset_windows_update
if "%choice%"=="15" goto open_msconfig
if "%choice%"=="16" goto safe_mode_restart
if "%choice%"=="17" goto repair_boot
if "%choice%"=="18" goto main_menu

goto entretien_pc

:sfc_scan
cls
echo ╔════════════════════════════════════╗
echo ║          SFC /scannow             ║
echo ╚════════════════════════════════════╝
echo.
sfc /scannow
pause
goto entretien_pc

:dism_checkhealth
cls
echo ╔════════════════════════════════════╗
echo ║  DISM /CheckHealth (image Windows) ║
echo ╚════════════════════════════════════╝
echo.
DISM /Online /Cleanup-Image /CheckHealth
pause
goto entretien_pc

:dism_scanhealth
cls
echo ╔════════════════════════════════════╗
echo ║   DISM /ScanHealth (image Windows) ║
echo ╚════════════════════════════════════╝
echo.
DISM /Online /Cleanup-Image /ScanHealth
pause
goto entretien_pc

:dism_restorehealth
cls
echo ╔════════════════════════════════════╗
echo ║ DISM /RestoreHealth (réparation)   ║
echo ╚════════════════════════════════════╝
echo.
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto entretien_pc

:chkdsk_repair
cls
echo ╔════════════════════════════════════╗
echo ║      chkdsk C: /F /R /X            ║
echo ╚════════════════════════════════════╝
echo.
chkdsk C: /F /R /X
pause
goto entretien_pc

:cleanmgr_run
cls
echo ╔════════════════════════════════════╗
echo ║    Nettoyage avancé (cleanmgr)     ║
echo ╚════════════════════════════════════╝
echo.
cleanmgr /sagerun:1
pause
goto entretien_pc

:flush_dns
cls
echo ╔════════════════════════════════════╗
echo ║       Vider le cache DNS           ║
echo ╚════════════════════════════════════╝
echo.
ipconfig /flushdns
pause
goto entretien_pc

:reset_winsock
cls
echo ╔════════════════════════════════════╗
echo ║    Réinitialiser Winsock           ║
echo ╚════════════════════════════════════╝
echo.
netsh winsock reset
pause
goto entretien_pc

:reset_ip
cls
echo ╔════════════════════════════════════╗
echo ║       Réinitialiser IP             ║
echo ╚════════════════════════════════════╝
echo.
netsh int ip reset
pause
goto entretien_pc

:show_errors
cls
echo ╔════════════════════════════════════╗
echo ║  10 dernières erreurs (journal)    ║
echo ╚════════════════════════════════════╝
echo.
wevtutil qe System /c:10 /rd:true /f:text
pause
goto entretien_pc

:check_smart
cls
echo ╔════════════════════════════════════╗
echo ║  Etat SMART du disque dur          ║
echo ╚════════════════════════════════════╝
echo.
wmic diskdrive get status
pause
goto entretien_pc

:list_processes
cls
echo ╔════════════════════════════════════╗
echo ║    Liste des processus en cours    ║
echo ╚════════════════════════════════════╝
echo.
tasklist /v
pause
goto entretien_pc

:find_large_files
cls
echo ╔════════════════════════════════════╗
echo ║   10 fichiers les plus volumineux   ║
echo ╚════════════════════════════════════╝
echo.
powershell -Command "Get-ChildItem C:\ -Recurse | Sort-Object Length -Descending | Select-Object -First 10"
pause
goto entretien_pc

:reset_windows_update
cls
echo ╔════════════════════════════════════╗
echo ║  Réinitialiser Windows Update     ║
echo ╚════════════════════════════════════╝
echo.
net stop wuauserv
net stop bits
net stop cryptsvc
del /f /s /q %SystemRoot%\SoftwareDistribution\*
del /f /s /q %SystemRoot%\System32\catroot2\*
net start wuauserv
net start bits
net start cryptsvc
echo.
echo Windows Update reinitialise.
pause
goto entretien_pc

:open_msconfig
cls
echo ╔════════════════════════════════════╗
echo ║          Ouvrir msconfig           ║
echo ╚════════════════════════════════════╝
echo.
start msconfig
pause
goto entretien_pc

:safe_mode_restart
cls
echo ╔════════════════════════════════════╗
echo ║   Redémarrer en mode sans échec    ║
echo ╚════════════════════════════════════╝
echo.
bcdedit /set {current} safeboot minimal
shutdown /r /t 0
goto entretien_pc

:repair_boot
cls
echo ╔════════════════════════════════════╗
echo ║   Réparer le démarrage de Windows  ║
echo ╚════════════════════════════════════╝
echo.
bootrec /fixmbr
bootrec /fixboot
bootrec /scanos
bootrec /rebuildbcd
pause
goto entretien_pc

:quitter
cls
echo ╔════════════════════════════════════╗
echo ║             Au revoir !            ║
echo ╚════════════════════════════════════╝
exit