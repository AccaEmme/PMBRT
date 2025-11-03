#!/bin/bash

# Path al file .bashrc dell'utente corrente
BASHRC="$HOME/.bashrc"

# Alias da aggiungere
ALIASES=$(cat <<EOF

# === Proxmox Backup & Restore Aliases ===
alias proxmox_my_backup='/usr/local/bin/proxmox-backup.sh'
alias proxmox_my_restore='/usr/local/bin/proxmox-restore.sh --source \$(ls -t /root/proxmox-backup-*.tar.gz | head -n1)'
# ========================================
EOF
)

# Controlla se gli alias sono già presenti
if grep -q "alias proxmox_my_backup=" "$BASHRC"; then
  echo "Gli alias sono già presenti in $BASHRC"
else
  echo "$ALIASES" >> "$BASHRC"
  echo "Alias aggiunti a $BASHRC"
fi

# Ricarica il file .bashrc
source "$BASHRC"
echo "Alias attivi. Puoi usare: proxmox_my_backup e proxmox_my_restore"
