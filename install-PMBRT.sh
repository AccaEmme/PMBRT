#!/bin/bash

# === Percorsi sorgente ===
SRC_BACKUP="proxmox-my_backup.sh"
SRC_RESTORE="proxmox-my_restore.sh"
SRC_ALIAS="proxmox-alias-setup.sh"

# === Percorsi destinazione ===
DEST_BACKUP="/usr/local/bin/proxmox-my_backup.sh"
DEST_RESTORE="/usr/local/bin/proxmox-my_restore.sh"

# === Copia e abilita gli script principali ===
echo "📦 Installazione script backup e restore..."
cp "$SRC_BACKUP" "$DEST_BACKUP"
cp "$SRC_RESTORE" "$DEST_RESTORE"
chmod +x "$DEST_BACKUP"
chmod +x "$DEST_RESTORE"
echo "✅ Script spostati e resi eseguibili."

# === Abilita e esegui lo script alias ===
echo "🔗 Configurazione alias..."
chmod +x "$SRC_ALIAS"
./"$SRC_ALIAS"
echo "✅ Alias configurati."

# === Ricarica variabili bash ===
echo "🔄 Ricarico ~/.bashrc..."
source ~/.bashrc

# === Aggiunta cron job settimanale ===
echo "⏰ Imposto backup settimanale ogni domenica alle 3:00..."
CRON_JOB="0 3 * * 0 /usr/local/bin/proxmox-my_backup.sh >> /var/log/proxmox-weekly-my_backup.log 2>&1"
( crontab -l 2>/dev/null; echo "$CRON_JOB" ) | crontab -
echo "✅ Cron job aggiunto."

echo "🎉 Installazione completata!"