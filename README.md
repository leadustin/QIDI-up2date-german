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


**Hardware**

+ <a href="https://eu.qidi3d.com/de/collections/x-plus-3-accessories/products/x-max-3-x-plus-3-x-smart-3-emmc-32g" target="_blank" rel="noopener noreferrer">EMMC-Reader</a>EMMC-Reader</a> – ich würde die 32GB EMMC von Qidi kaufen, da ist der Reader mit dabei
+ <a href="https://www.amazon.de/s?k=sd+card+adapter+usb&crid=15YOTDZUGFJQ2&sprefix=sd+card+a%2Caps%2C113&ref=nb_sb_ss_ts-doa-p_2_9" target="_blank" rel="noopener noreferrer">SD-Card-Adapter auf MicroSD oder USB-Adapter auf MicroSD</a>
+ <a href="https://www.amazon.de/s?k=micro+sd+karte&crid=3IBXHOHP33HS4&sprefix=micro%2Caps%2C111&ref=nb_sb_ss_ts-doa-p_1_5" target="_blank" rel="noopener noreferrer">MicroSD-Karte - maximal 32GB</a>
+ Optional 5+ Zoll Touchdisplay und ein Raspberry ab Version 3


**Software**


+ <a href="https://etcher.balena.io/" target="_blank" rel="noopener noreferrer">balenaEtcher</a> - zum flashen des Betriebssystems auf die EMMC
+ <a href="https://github.com/redrathnure/armbian-mkspi" target="_blank" rel="noopener noreferrer">Armbian Image</a> - Abbild des zu flashenden Betriebssystems
+ <a href="https://www.raspberrypi.com/software/" target="_blank" rel="noopener noreferrer">Raspberry Imager</a>
+ <a rel="noopener noreferrer" href="https://www.chiark.greenend.org.uk/~sgtatham/putty/" target="_blank">Putty</a> - Tool um per SSH auf den Drucker zuzugreifen
+ <a href="https://winscp.net/eng/download.php" target="_blank" rel="noopener noreferrer">WinSCP</a> - Tool um per FTP auf den Drucker zugreifen zu können

**Backup**

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

Als nächstes erfolgt die Installation von KIAUH (Klipper Installation And Update Helper) Dieses nützliche Tool installiert, aktualisiert und deinstalliert automatisch von uns ausgewählte Tools. Wie gehabt die Befehle pro Zeile einzeln eingeben um mit der Installation zu starten.

```bash
sudo apt-get update && sudo apt-get install git -y
cd ~ && git clone https://github.com/dw-0/kiauh.git
./kiauh/kiauh.sh
```

Nach erfolgreicher Installation solltet ihr euch im Hauptmenü von KIAUH befinden.

Über Menüpunkt 1 diese Software in dieser Reihenfolge installieren. Klipper->Moonraker->Mainsail. Klipper fragt während der Installation nach der Python-Version, immer Version 3 auswählen! Bei der Anzahl der Instanzen wählt ihr 1. Bei der Installation von Mainsail wird die Frage gestellt, ob Macros installiert werden sollen. Hier mit JA antworten. Die Installation wird einige Zeit in Anspruch nehmen, daher geduldig sein auch wenn sich in der Konsole mal nichts tut. So sollte das am Ende in KIAUH aussehen.

![Putty](https://github.com/leadustin/QIDI_aktuell/blob/main/images/kiuah_tools.png)


Die IP des Druckers im Browser eingeben und so auf die Weboberfläche zu verbinden.
Es wird eine Fehlermeldung ausgegeben, da auf diversen MCUs eine veraltete Klipper-Firmware installiert ist. Kein Grund zur Panik. Jetzt beginnt der Spaß.

## Flashen des Druckkopfs
Um ihn zu flashen, müssen wir ihn in den "dfu-Modus" versetzen. Dies erfordert das physische Drücken von 2 Knöpfen. Dies wird nur einmal nötig sein, da wir einen speziellen Bootloader Namens "katapult" flashen werden, zukünftige Firmwareupdates können dann ohne physischen Zugriff erfolgen.

    Installation von katapult. Wir verbinden uns mit Putty per SSH auf unseren Drucker und loggen uns mit mks/makerbase ein. Nach dem Einloggen nachfolgende Befehle in die Konsole eingeben:

Code

git clone https://github.com/Arksine/katapult
cd ~/katapult
make menuconfig


Wir befinden uns nun im Katapult-Konfigurations-Menü. Zuerst ändern wir die Section “Micro-controller Architecture" auf RP2040. Als nächstes sicherstellen, das unter „Build Katapult deployment application der Bootloader auf „16KiB bootloader“ steht. Mit “Q” beenden und mit „Y“ speichern. Noch mal querchecken ob alles wie auf dem Bild eingestellt ist.

forum.drucktipps3d.de/attachment/113152/


Jetzt erstellen wir unsere erste Firmware in dem wir nachfolgenden Befehl eingeben:

Code

make clean
make -j4


    In der Konsole solltet ihr folgende Ausgabe sehen:


forum.drucktipps3d.de/attachment/113153/



    Nachfolgenden Befehl in die Konsole für folgende Ausgabe eingeben. Man sieht das auf dem Druckkopf Klipper installiert ist. Beachtet das die ID auf dem Bild, die meines Druckers ist!

Code

ls /dev/serial/by-id/*

forum.drucktipps3d.de/attachment/113154/
