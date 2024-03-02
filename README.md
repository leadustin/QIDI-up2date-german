Ich möchte in diesem Repository meine Aktualisierung des Qidi X-Plus 3 auf die aktuellste Software inkl. einiger nützlicher und optionaler Tools mit euch teilen.

Dieses Tutorial basiert auf der Arbeit von coco.33 und wurde in seiner Urfassung <a href="https://github.com/Phil1988/FreeQIDI">auf FreeQIDI</a>
veröffentlicht und bezieht sich auf die Qidi X-3 Serie.
> [!CAUTION]
>Bitte beachtet, dass weder ich noch eine andere dritte Personen für Schäden an eurem Drucker verantwortlich sind, solltet ihr diesem Tutorial folgen.
>Ihr werdet das System komplett von null neu aufsetzen. Dies beinhaltet auch das Flashen aller MCUs wie Druckkopf oder den STM-Chip des Mainboards.
>All eure Gcodes sowie eure derzeitige printer.cfg sollten daher gesichert werden.
>Solltet ihr damit einverstanden sein, und Änderungen durchgeführt werden, erlischt auch jeglicher Garantieanspruch an Qidi.


## Warum sollte man seinen Qidi aktualisieren?


Die Hardware des Druckers an sich ist solide und hat das Potential für sehr gute Druckergebnisse.
Der Flaschenhals der Serie 3 ist jedoch die veraltete Software.
Als Betriebssystem läuft ein Armbian Buster aus dem Jahre 2022, welches zusätzlich mit unnötigen Datenmüll einherkommt. Klipper läuft im Originalzustand auf Version 0.10 anstatt Version 0.12.
Moonraker ist bei Version 0.7.xxx, aktuell ist jedoch Version 0.8.xxx.
Selbst die Weboberfläche fluidd ist outdated. Nicht minder kritisch ist es bei Python.
Hier werden 2 Versionen mitgeschleppt. Einmal das alte Python 2.7 und Python 3.7.
Aktuell sind wir bei Version 3.12.


Mit einer Aktualisierung des kompletten Systems bekommt man die Möglichkeit, jegliche derzeit aktuelle Software zu nutzen und den Drucker, um einige nützliche Tools zu erweitern. Der benötigte Speicherplatz auf der EMMC sinkt von derzeit knapp 6,5GB auf rund 3GB. Falls ihr die originale Speicherkarte weiter benutzen, wollt, ist dies ein nicht zu unterschätzender Faktor.

Ich persönlich würde jedoch zur 32 GB-Karte von Qidi raten, da mit einigen zusätzlichen Tools der Speicherverbrauch schnell die 8GB überschreitet. Vereinfacht gesagt bekommt ihr einen Drucker, welcher richtig konfiguriert dem Original überlegen ist und der dem Gedanken von Open Source so nah wie nur möglich kommt.


Wo Licht ist, ist leider auch Schatten. In diesem Fall betrifft das das originale Display des Druckers. Dieses lässt sich derzeit nach der Aktualisierung nicht mehr benutzen. Das Display ist im Prinzip ein eigenes System auf dem die Druckoberfläche des Druckers läuft und seriell an das Mainboard angeschlossen ist. Aufgrund diverser Modifikationen an Klipper und Moonraker durch Qidi hat man so eine Schnittstelle zwischen Display und System geschaffen. Dies ist somit auch der Grund warum eine Aktualisierung von Moonraker bzw. Klipper auf einem bestehenden System diese Fehlermeldung erzeugt.

![Fehlermeldung](https://github.com/leadustin/QIDI_aktuell/blob/main/images/display_error.png)

Eine Alternative für das Display stelle ich später im Tutorial vor.

## Noch interessiert? Dann starten wir jetzt durch.


Was wird alles benötigt?


### **Hardware**

+ <a href="https://eu.qidi3d.com/de/collections/x-plus-3-accessories/products/x-max-3-x-plus-3-x-smart-3-emmc-32g" target="_blank" rel="noopener noreferrer">EMMC-Reader</a>EMMC-Reader</a> – ich würde die 32GB EMMC von Qidi kaufen, da ist der Reader mit dabei
+ <a href="https://www.amazon.de/s?k=sd+card+adapter+usb&crid=15YOTDZUGFJQ2&sprefix=sd+card+a%2Caps%2C113&ref=nb_sb_ss_ts-doa-p_2_9" target="_blank" rel="noopener noreferrer">SD-Card-Adapter auf MicroSD oder USB-Adapter auf MicroSD</a>
+ <a href="https://www.amazon.de/s?k=micro+sd+karte&crid=3IBXHOHP33HS4&sprefix=micro%2Caps%2C111&ref=nb_sb_ss_ts-doa-p_1_5" target="_blank" rel="noopener noreferrer">MicroSD-Karte - maximal 32GB</a>
+ Optional 5+ Zoll Touchdisplay und ein Raspberry ab Version 3


### **Software**


+ <a href="https://etcher.balena.io/" target="_blank" rel="noopener noreferrer">balenaEtcher</a> - zum flashen des Betriebssystems auf die EMMC
+ <a href="https://github.com/redrathnure/armbian-mkspi" target="_blank" rel="noopener noreferrer">Armbian Image</a> - Abbild des zu flashenden Betriebssystems
+ <a href="https://www.raspberrypi.com/software/" target="_blank" rel="noopener noreferrer">Raspberry Imager</a>
+ <a rel="noopener noreferrer" href="https://www.chiark.greenend.org.uk/~sgtatham/putty/" target="_blank">Putty</a> - Tool um per SSH auf den Drucker zuzugreifen
+ <a href="https://winscp.net/eng/download.php" target="_blank" rel="noopener noreferrer">WinSCP</a> - Tool um per FTP auf den Drucker zugreifen zu können

### **Backup**

+ Da das komplette System gelöscht wird, erstellt bitte ein Backup eurer G-Codes und der printer.cfg
+ Zusätzlich wird eine LAN-Verbindung für die Einrichtung des Systems benötigt. WLAN geht NICHT!


## Nachfolgend eine möglichst detailierte Anleitung, die durch den Update-Prozess führt.


Da wir am offenen Gerät arbeiten, muss zuerst die Stromversorgung unterbrochen werden.
Dreht euren Drucker so, das ihr gut an der Rückseite die Schrauben der Abdeckung entfernen könnt. Mit Hilfe dieser <a href="https://drive.google.com/drive/folders/1EPYKbYz4ecUIf17z5wtP-jDAOPeDkXJP" target="_blank" rel="noopener noreferrer">Anleitung</a> baut ihr die EMMC aus. Bevor ihr die EMMC ausbaut, einmal sich selbst erden und ein Backup eurer Gcodes nicht vergessen.
Sicher ist sicher.
+ Die EMMC per EMMC-Reader mit dem PC verbinden.
+ balenaEtcher starten und das vorher heruntergeladene <a href="https://github.com/redrathnure/armbian-mkspi" target="_blank">Armbian Image</a> auf die EMMC flashen.

![Balena](https://github.com/leadustin/QIDI_aktuell/blob/main/images/balena.png)

+ Entsprechend der Anleitung die EMMC wieder auf dem Mainboard einstecken.
+ LAN-Kabel und Stromversorgung anschließen.
+ Drucker einschalten – Das System fährt nun hoch und der Drucker bekommt seine IP vom Router zugewiesen.
+ Router öffnen und die derzeitige IP des Druckers heraussuchen und dem Drucker fest zuweisen. Nachfolgend ein Bild der Einstellungen auf der Fritz!Box. Wer einen anderen Router hat, muss selber suchen.

![Fritz!Box](https://github.com/leadustin/QIDI_aktuell/blob/main/images/fritzbox_ip.png)


+ Putty starten und entsprechend konfigurieren. Verbindung per SSH auf den Drucker. User ist „root“ und Passwort „1234“. Es folgt nun die Ersteinrichtung des Armbian OS. Unteranderem müsst ihr dem User "root" ein neues Passwort geben, die Zeitzone und eure favorisierte Shell auswählen. Ich benutze bash.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/putty.png)


+ Ihr werdet aufgefordert einen neuen Nutzer anzulegen. Als Namen tragt ihr „mks“ und als Passwort „makerbase“ ein. Aufforderungen einen Real-Namen und eine Telefonnummer einzugeben könnt ihr ignorieren und mit Enter bestätigen.
+ Verbindung zum Drucker neustarten und mit dem zuvor erstellten User einloggen.
+ Aktualisierung des Betriebssystems mit folgenden Befehlen:

```bash
sudo apt update
sudo apt upgrade
```

Ich empfehle die Befehle immer zeilenweise in die Konsole einzugeben und abzuwarten bis der jeweilige Befehl abgearbeitet wurde. Einfügen in Putty erfolgt per Rechtsklick. Wollt ihr etwas aus Putty kopieren, reicht es den Text mit gedrückter linker Maustaste zu markieren. Der Text wird automatisch in die Windows-Zwischenablage kopiert.

### **Installation von KIAUH** (Klipper Installation And Update Helper)

Dieses nützliche Tool installiert, aktualisiert und deinstalliert automatisch von uns ausgewählte Tools. Wie gehabt die Befehle pro Zeile einzeln eingeben um mit der Installation zu starten.

```bash
sudo apt-get update && sudo apt-get install git -y
cd ~ && git clone https://github.com/dw-0/kiauh.git
./kiauh/kiauh.sh
```

Nach erfolgreicher Installation solltet ihr euch im Hauptmenü von KIAUH befinden.

Über Menüpunkt 1 diese Software in dieser Reihenfolge installieren. Klipper->Moonraker->Mainsail. 
Klipper fragt während der Installation nach der Python-Version, immer Version 3 auswählen! Bei der Anzahl der Instanzen wählt ihr 1. 
Bei der Installation von Mainsail wird die Frage gestellt, ob Macros installiert werden sollen. Hier mit JA antworten. 

Die Installation wird einige Zeit in Anspruch nehmen, daher geduldig sein auch wenn sich in der Konsole mal nichts tut. So sollte das am Ende in KIAUH aussehen.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/kiuah_tools.png)


Die IP des Druckers im Browser eingeben und so auf die Weboberfläche zu verbinden.
Es wird eine Fehlermeldung ausgegeben, da auf diversen MCUs eine veraltete Klipper-Firmware installiert ist. Kein Grund zur Panik. Jetzt beginnt der Spaß.
![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper_mcu_error.png)

### **Flashen des Druckkopfs**

Um ihn zu flashen, müssen wir ihn in den "dfu-Modus" versetzen. Dies erfordert das physische Drücken von 2 Knöpfen. Dies wird nur einmal nötig sein, da wir einen speziellen Bootloader Namens "katapult" flashen werden, zukünftige Firmwareupdates können dann ohne physischen Zugriff erfolgen.

### **Installation von katapult**

Wir verbinden uns mit Putty per SSH auf unseren Drucker und loggen uns mit mks/makerbase ein. Nach dem Einloggen nachfolgende Befehle in die Konsole eingeben:

```bash
git clone https://github.com/Arksine/katapult
cd ~/katapult
make menuconfig
```

Wir befinden uns nun im Katapult-Konfigurations-Menü.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult1.png)

Zuerst ändern wir die Section “Micro-controller Architecture" auf RP2040.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult2.png)

Als nächstes sicherstellen, das unter „Build Katapult deployment application der Bootloader auf „16KiB bootloader“ steht.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult3.png)

Mit “Q” beenden und mit „Y“ speichern.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult4.png)


Jetzt erstellen wir unsere erste Firmware in dem wir nachfolgenden Befehl eingeben:

```bash
make clean
make -j4
```

In der Konsole solltet ihr folgende Ausgabe sehen:


![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult5.png)



Nachfolgenden Befehl in die Konsole für folgende Ausgabe eingeben. Man sieht das auf dem Druckkopf Klipper installiert ist. Beachtet das die ID auf dem Bild, die **MEINES** Druckers ist!

```bash
ls /dev/serial/by-id/*
```
![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/katapult6.png)


Druckkopf in DFU-Mode versetzen. Hierfür wie folgt vorgehen:

+ Hintere Abdeckung des Druckkopfs entfernen
+ Boot-Knopf drücken und gedrückt halten
+ Reset-Knopf drücken und wieder loslassen
+ Boot-Knopf loslassen



Folgende Befehle in die Konsole eingeben um das Flashen des Druckkopfs vorzubereiten:

```bash
sudo mount /dev/sda1 /mnt
systemctl daemon-reload
```

![Flash Toolhead](https://github.com/leadustin/QIDI_aktuell/blob/main/images/flash_1.png)


Es folgt eine Abfrage des Passworts des User mks. Hier also makerbase eintragen.


![Flash Toolhead](https://github.com/leadustin/QIDI_aktuell/blob/main/images/flash_2.png)




Nachfolgende Befehle flashen Katapult auf den Druckkopf:

```bash
sudo cp out/katapult.uf2 /mnt
sudo umount /mnt
```


Wenn nachfolgender Befehl eingegeben wird, sollte die Bestätigung angezeigt werden, das Katapult auf dem Druckkopf läuft.

```bash
ls /dev/serial/by-id
```

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/flash_3.png)



Von nun an, können zukünftige Versionen von Klipper ohne physischen Zugriff auf den Druckkopf geflasht warden. Nicht vergessen die Abdeckung des Druckkopfs zu montieren.


Jetzt müssen wir Klipper auf den Druckkopf flashen, Folgende Befehle in die Konsole eingeben:

```bash
cd ~/klipper
make menuconfig
```

Im Prinzip wird hier ähnlich des Konfig-Menüs von Katapult verfahren. Wie auf dem nachfolgenden Bild dargestellt das Menü konfigurieren.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper1.png)

Mit "Q" beenden und mit "Y" speichern.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper2.png)

Mit nachfolgenden Befehlen wird die Firmware kompliliert:

```bash
make clean
make -j4
```
Dies sollte anch dem kompillieren der Firmware in der Konsole stehen. Die Warnung kann ignoriert werden.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper3.png)

> [!WARNING]
> Mit nachfolgenden Befehl die ID aufrufen und alles nach „usb-katapult_rp2040_“ in den Zwischenspeicher kopieren und dann in eine .txt-Datei. Dies ist **EURE** Serial-ID des Druckkopfs. Alle IDs auf diesen       > Bildern sind die **MEINES** Druckers und dürfen nicht auf **EUREN** Drucker geflasht werden.

```bash
ls /dev/serial/by-id/*
```

Das muss in eurer Konsole stehen - “/dev/serial/by-id/usb-katapult_rp2040_EURE-ID”

Installation python3-serial mit folgeden Befehl. Dies ermöglicht es uns den Druckkopf zu flashen.

```bash
sudo apt install python3-serial
```

> [!WARNING]
> ### **Flashen des Druckkopfs**
> Stellt sicher, dass ihr auch **EURE ID** benutzt. Nachfolgenden Befehl komplett mit **EURER ID** in die Konsole einfügen. **Eure ID** habt ihr in einer Text-Datei zwischengespeichert.
>
> ```bash
> python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-katapult_rp2040_EURE_ID
> ```

So sollte es in der Konsole aussehen:

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper4.png)



Fertig! Der Druckkopf ist auf Klipper 0.12 geflasht.


## **Flashen des STM32F402 auf dem Mainboard.** 

Vorgehensweise ähnlich des Flashvorgangs des rp2040. Nachfolgende Befehle in die Konsole eingeben:

```bash
cd ~/klipper
make menuconfig
```


Alles wie auf dem Bild dargestellt einstellen und wieder mit "Q" beenden und "Y" speichern

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper5.png)




Jetzt wird die letzte Firmware mit folgenden Befehl kompiliert:

```bash
make clean
make -j4
```


Dieser Prozess erstellt eine „klipper.bin“ im Ordner /home/mks/klipper/out/. Die Warnung während des Kompilierens kann ignoriert werden.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper6.png)


In WinSCP ein neues Verbindungsziel erstellen, die IP des Druckers eintragen. Benutzername und Passwort leer lassen und auf "speichern" klicken. Als nächstes auf "anmelden" drücken und im nächsten Fenster die Login-Daten des Users mks eintragen und die klipper.bin, wie im Bild gezeigt aus /home/mks/klipper/out/ herunterladen.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper7.png)

+ Die MicroSD-Card als FAT32 formatieren. Wichtig! Keine Karte größer 32GB benutzen!
+ Die klipper.bin in X_4.bin umbenennen und auf die SD-Karte direkt ins Root-Verzeichnis kopieren.
+ Die MicroSD-Karte auswerfen.
+ Den Drucker am Netzschalter ausschalten und mindestens 30 Sekunden warten, damit sich der Superkondensator entladen kann.
+Die MicroSD-Karte in den Kartenslot des Mainboards stecken und den Drucker wieder anschalten. Die STM32F402 MCU wird nun geflasht. Der Prozess sollte ungefähr 10 Sekunden dauern. Zur Sicherheit den Drucker erst nach 1 Minute ausstellen und die SD-Karte entfernen.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper8.png)

Den Stecker des Display vom Mainboard ziehen, da dieses nur eine Fehlermeldung anzeigen wird. Drucker anschalten und auf die Weboberfläche zugreifen. Im Tab "Maschine" sollte nun nachfolgendes Bild angezeigt werden. Die Fehlermeldung bzgl. der mcu MKS_THR wird erstmal ignoriert. Darum kümmern wir uns später.

Hintere Abdeckung des Druckers montieren und dabei achten, die Schrauben nicht zu fest ins Gewinde zu drehen, da man hier leider nur in Plastik schraubt. Wer auch das alternative Touchdisplay installieren möchte, kann den Drucker offen lassen.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/klipper9.png)


## **Herzlichen Glückwunsch - das Fundament ist geschaffen.**

> [!IMPORTANT]
> Vorab noch eine Klarstellung. Wenn ihr dem Guide weiter folgt, bekommt ihr den Softwarestand der aktuell auf meinem Drucker ist.
> Falls ihr das nicht wollt und euren Drucker anders konfigurieren möchtet, dann ist dies der Zeitpunkt abzuspringen. Klipper, Moonraker und Mainsail sind up to date. Was zu flashen war wurde geflasht.
>
> Es muss nun lediglich die printer.cfg von euch angepasst werden. Das bedeutet es müssen die Pin-Belegungen, Extruder, Lüfter im Prinzip der komplette Hardwareteil plus Macros eingepflegt werden.
> Dafür könnt ihr eure alte printer.cfg ausschlachten. Wer das nicht möchte folgt weiter dem Guide.

## **printer.cfg**

Die printer.cfg ist quasi das Herzstück des Druckers. In ihr sind alle Einstellungen der Hardware wie Extruder, Lüfter etc. gespeichert.
Sie enthält in der Regel alle benötigten Macros und Verweise auf Configs anderer Tools. Derzeit fehlen in der printer.cfg wichtige Einträge.
Dies ist auch der Grund warum es auf der Weboberfläche eine Fehlermeldung gibt.

Wer weis was er macht und sich seine printer.cfg entsprechend seinen Vorstellungen und Wünschen konfigurieren möchte, kann diesen Part überspringen. Für alle anderen weiter im Text.



Die originale printer.cfg von Qidi ist ein ziemliches Durcheinander mit teils sinnlosen und gefährlichen Macros - Stichwort wäre hier "Force_Move".
Da werden so einige Druckköpfe in die Druckbetten gefahren sein.
Die von mir angebotenen printer.cfg sind für den X-Plus 3 sowie für den X-Max 3.
Für eine bessere Übersicht enthalten diese printer.cfg nur technische Einstellungen für die Hardware des Druckers.
Alles was Macros betrifft ist in einer eigenen macro.cfg gesammelt. Dazu kommen noch ein paar separate Configs.
Alles per "include" in die printer.cfg eingebunden.


    Die dem Drucker entsprechende RAR-Datei herunterladen und entpacken
    Mainsail aufrufen und im Tab "Maschine" die printer.cfg löschen und über "Datei hochladen" die printer.cfg aus dem Archiv hochladen


    in Mainsail auf printer.cfg klicken - es öffnet sich der Mainsail-Editor
    Folgenden Abschnitt suchen und dort EURE ID eintragen.

[mcu MKS_THR]
[serial:/dev/serial/by-id/usb-Klipper_rp2040_55DA4D9503AF5658-if00

    Im Mainsail-Editor auf "Speichern und Neustart" klicken. Klipper wird neu gestartet und lädt alle Configs.
    Wenn die ID unter mcu MKS_THR korrekt eingetragen wurde, sollte auch die mcu-bezogene rote Fehlermeldung weg sein. Dafür haben wir jetzt eine andere rote Fehlermeldung. Es fehlt die Adaptive_Mesh.cfg. Diese befindet sich in der heruntergeladenen RAR-Datei im Ordner "Macros".
    Erstellt In Mainsail einen Ordner mit dem Namen "Macros" über den Button "Verzeichnis erstellen"


    Öffnet diesen Ordner und ladet alle Dateien aus dem entpackten Ordner "Macros" hoch

Da uns noch ein paar Dateien fehlen, starten wir nun Putty und loggen uns mit mks/makerbase auf den Drucker ein.

    Nachfolgenden Befehl in die Konsole eingeben

./kiauh/kiauh.sh

    KIAUH öffnet sich und über Punkt 1 in die Installation wechseln
    Installation Crownsnest wählen und während der Installation alles mit "Yes" bestätigen. Crownsnest ist für die Konfiguration einer oder mehrerer Webcams verantwortlich. Nach der Installation die "crownsnest.conf" im Mainsail Editor öffnen und entsprechend eure Webcam konfigurieren und dann "Speichern und Neustart" klicken.
    Installation Octoeverywhere wählen und während der Installation alles mit "Yes" bestätigen. Zum Ende der Installation wird in der Konsole ein mehrstelliger Code angezeigt. Diesen Code gebt ihr auf Octoeverywhere.com/code ein und folgt den Anweisungen. Octoeverywhere ist ein Remote-Tool mit dem ihr über das Internet euren Drucker steuern könnt.
    KIAUH schließen

Es fehlen noch 3 Tools, die wir jetzt installieren werden. Zum einen wäre das Klippain Shake&Tune, Mainsail Timelapse und Spoolman.


    Mainsail Timelapse ist ein Tool mit dem Zeitraffer-Videos der Drucke erstellt werden können. Folgende Befehle für die Installation von Mainsail Timelapse in der Konsole ausführen:

cd ~/
git clone https://github.com/mainsail-crew/moonraker-timelapse.git
cd ~/moonraker-timelapse
make install

    Nach der Installation von Mainsail Timelapse befindet sich im Ordner "Config" die Datei "timelapse.cfg. Diese kopiert ihr in Mainsail per Drag&Drop in den Ordner "Macros".
    Damit Mainsail Timelapse richtig funktioniert, müssen wir noch ffmpeg installieren. Folgenden Befehl wieder in die Konsole einfügen:

sudo apt install ffmpeg

    Damit wir später Aktualisierungsbenachrichtigungen bei Updates bekommen, öffnen wir in Mainsail die moonraker.conf und fügen am Ende der Datei folgendes ein:

[update_manager timelapse]
type: git_repo
primary_branch: main
path: ~/moonraker-timelapse
origin: https://github.com/mainsail-crew/moonraker-timelapse.git
managed_services: klipper moonraker

    Im Mainsail-Editor dann auf "Speichern und Neustart" drücken.
