# PMBRT - Proxmox My Backup \& Restore Toolkit
Questo repository contiene una serie di script per eseguire backup e restore sicuri della configurazione di Proxmox VE, con supporto per alias automatici e backup pianificati.
Dopo aver accidentalmente perso le configurazioni, 

## 📦 Contenuto
- `proxmox-my_backup.sh`  

&nbsp; Script parametrico per creare backup della configurazione Proxmox, con opzioni per includere i dischi delle VM/container e specificare la destinazione.
- `proxmox-restore.sh`  

&nbsp; Script per ripristinare un backup `.tar.gz` in modo sicuro.

- `proxmox-alias-setup.sh`  

&nbsp; Script che aggiunge automaticamente gli alias `proxmox\_my\_backup` e `proxmox\_my\_restore` al file `.bashrc` dell’utente corrente.

---

## 🚀 Installazione manuale
1\. Copia gli script nei percorsi indicati
### 📁 Dove posizionare i file
| File                      | Percorso consigliato                  | Permessi       |
| --------------------------- | ---------------------------------------- | ----------------- |
| `proxmox-my_backup.sh`       | `/usr/local/bin/proxmox-my_backup.sh`     | `chmod +x`      |
| `proxmox-my_restore.sh`      | `/usr/local/bin/proxmox-my_restore.sh`    | `chmod +x`      |
| `proxmox-alias-setup.sh`  | Qualsiasi cartella, esegui una volta   | `chmod +x`      |


2\. Rendi eseguibili i file:
```bash
chmod +x /usr/local/bin/proxmox-my_backup.sh
chmod +x /usr/local/bin/proxmox-my_restore.sh
chmod +x proxmox-alias-setup.sh
```

Esegui solo una volta lo script alias: 
```bash
./proxmox-alias-setup.sh
```
Ricarica le variabili del tuo .bashrc: 
```bash
source ~/.bashrc
```

---

## 🚀 Installazione automatica
```bash
git clone https://github.com/AccaEmme/PMBRT.git
cd PMBRT
ls -alh
chmod +x install-PMBRT.sh
./install-PMBRT.sh
```

---

## 🚀 Modalità di utilizzo

### 🔹 Backup base (senza dischi VM)
```bash
proxmox_my_backup
```

### 🔹 Backup completo (inclusi dischi VM)
```bash
proxmox-my_backup.sh --include-images --dest /mnt/usb/proxmox-full.tar.gz
```

### 🔹 Restore dell'ultimo backup
```bash
proxmox_my_restore
```

### 🔹 Restore da file specifico
```bash
proxmox-restore.sh --source /mnt/usb/proxmox-full.tar.gz
```

## ⏰ Backup automatico
### 🔸 Verifica gli scheduler in corso
```bash
crontab -e
```
### 🔸 Sintassi di base di crontab
Ogni riga del crontab ha questa struttura:
```
MINUTO ORA GIORNO_DEL_MESE MESE GIORNO_DELLA_SETTIMANA COMANDO
```
| Campo | Valori Possibili | Esempio |
| ----- | ---------------- | ------- |
| Minuto | 0-59 | * |
| Ora | 0-23 | * |
| Giorno del mese | 1-31 | * |
| Mese | 1-12 | * |
| Giorno della settimana | 0-7 ( 0 e 7 = domenica) | 0 quindi domenica |
| Comando | Qualsiasi comando o script | /usr/local/bin/proxmox-my_backup.sh |


### 🔸 Esempi di crontab scheduled time
#### 🔸 Esempio: Backup giornaliero alle 2:00
```bash
0 2 * * * /usr/local/bin/proxmox-my_backup.sh >> /var/log/proxmox-backup.log 2>&1
```

#### 🔸 Esempio: Backup giornaliero alle 3:00 ogni domenica
```bash
0 3 * * 0 /usr/local/bin/proxmox-my_backup.sh >> /var/log/proxmox-weekly-my_backup.log 2>&1
```

## 📂 Cosa viene salvato

| **Percorso**      |  **Default**      | **Contenuto salvato**  |
| ------------- | ------------- | ------------- |
| /etc/pve | ✅ | Configurazioni cluster, VM, container, utenti, ACL |
| /etc/network/interfaces | ✅ | Configurazione di rete |
| /var/lib/vz | ✅ | Storage locale, container LXC, backup .vma.gz |
| /var/lib/vz/images/ | ❌ solo se --include-images | Dischi VM (.qcow2, .raw) |
| /var/lib/vz/dump/ | ❌ solo se --include-images | Backup VM |
 

📜 Licenza
Questo progetto è rilasciato sotto licenza Creative Commons Attribution 4.0 International (CC BY 4.0).

✅ Puoi:
- Copiare, distribuire e trasmettere il materiale
- Modificarlo e adattarlo per qualsiasi scopo, anche commerciale

📌 A condizione che:
- Venga sempre attribuita la paternità originale dell’opera
- Si includa un riferimento al repository o all’autore originale
- Si indichi se sono state apportate modifiche

Per maggiori dettagli, consulta il testo completo della licenza su [creativecommons.org](creativecommons.org).