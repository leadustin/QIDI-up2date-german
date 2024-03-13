#!/bin/bash

# IP-Adresse des Klipperscreens
ip="192.168.188.46"

# Benutzername und Passwort
user="mks"
password="makerbase"

# Countdown-Funktion definieren
countdown() {
    for i in {5..1}; do
        echo "Herunterfahren des Klipperscreens in: $i"
        sleep 1
    done
    echo "Herunterfahren des Klipperscreens in: 0"
}

# Countdown ausgeben
echo "Herunterfahren des Klipperscreens in:"
countdown

# SSH-Verbindung mit deaktivierter Host-Key-Prüfung herstellen und Klipperscreen herunterfahren
sshpass -p "$password" ssh -o StrictHostKeyChecking=no $user@$ip "sudo shutdown -h now -n"

# Überprüfen, ob der Klipperscreen heruntergefahren wurde
sshpass -p "$password" ssh -o StrictHostKeyChecking=no $user@$ip "pgrep klipperscreen > /dev/null"
if [ $? -eq 0 ]; then
  echo "Fehler: Klipperscreen wurde nicht heruntergefahren!"
  exit 1
fi

echo "Herunterfahren abgeschlossen!"

