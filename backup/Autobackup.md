# **Github-Backup**
Dieser Guide beschreibt den Weg  seine Configs, Macros etc. manuell oder automatisch in sein eigenes Github-Repository hochzuladen und bei Bedarf auch als Backup auf seinem 3D-Drucker wiederherzustellen.
Um den Guide besser folgen zu können, sind alle Konsolenbefehle für Copy&Paste vorbereitet. Ebenso sind diesem Guide Bilder hinzugefügt um einzelne Schritte besser verständlich zu machen.

## **Was wird benötigt?**
+ ein 3D-Drucker
+ Putty für eine SSH-Verbindung
+ einen Account bei Github

## **Wo für braucht man so etwas?**
Wer seinen Drucker optimiert und zusätzliche Software installiert, ändert zwangsläufig seine Configs. Dabei kann etwas schiefgehen, man hat alte Werte vergessen oder komplett gelöscht.
Mit diesem Guide hat man die Möglichkeit bequem über Github seine Daten zu sichern und nachzuvollziehen, welche Änderungen man wo gemacht hat und diese bei Bedarf zu ändern.
Das nachfolgende Bild zeigt eine Änderung eines Kommentars in der printer.cfg. 
+ Rot ist der urspüngliche Wert und grün zeigt den derzeitigen Wert.

![Backup](/../main/images/backup1.png)

## **Eigenes Github Repository erstellen**
> [!NOTE]
> Solltest du noch keinen Github-Account besitzen, kannst du dir <a href="https://github.com/signup">hier</a> einen Account erstellen.
+ Einloggen in den erstellten Github Account
+ Erstellen eines neuen Github Repository durch klicken auf NEW

![Neues Repository](/../main/images/backup2.png)

Die nächsten Schritte sind die Namensfindung, Zugriffsberechtigung und diverse andere Einstellungen.
1. Namen des Repository
   + Einen aussagekräftigen Namen wählen. Falls man plant mehrere Drucker einzupflegen, wäre hier der Name des jeweiligen Drucker sinnvoll

2. Beschreibung Repository
   + Die Beschreibung des Respository ist optional. Hier könnte der Drucker detailierter beschrieben werden.

3. Public oder privat
   + Soll das Repository für alle zugänglichs ein muss public gewählt werden andernfalls private wählen.

4. Initialisierung des Repositorys
   + Dieser Teil definiert welche Grunddateien im Repository enthalten sind. Wie im nachfolgenden Bild auswählen.
     + Add a README file - **Checkbox leer**
     + Add .gitignore - **NONE**
     + Choose a licence - **NONE** - Dieser Punkt ist optional. Wer mag kann sich die entsprechgende Lizenz seiner Wahl auswählen.
    
5. Repository erstellen
   + Mit Klick auf "create repository" wird das eigene Repository erstellt.
    
![Initialisierung](/../main/images/backup3.png)

Nach Erstellung des Repository erfolgt eine Weiterleitung zum derzeitigen "Root-Verzeichnis" 
Kopiert die HTTPS-URL eurers Repository und fügt diese in einen Texteditor eurer Wahl ein. 

![HTTPS-URL](/../main/images/backup4.png)

## **Zugriffs-Token erstellen**
Um Zugriff auf das Repository über den Drucker zu erhalten, benötigen wir ein "access token" welches wir <a href="https://github.com/settings/tokens">hier</a> erstellen.
+ Auf "Generate new  token" klicken
+ "Generate new token (classic) wählen

![Token-Auswahl](/../main/images/backup5.png)

Im nächsten Schritt wird das Token mit entsprechenden Zugriffsrechten konfiguriert
1. Namen des Tokens
   + Unter "Note" wählt ihr einen passenden Namen, welcher mit eurem Drucker in Verbindung gebracht werden kann.
2. Gültigkeitsdauer
   + Unter Expiration "No expiration" auswählen.
> [!TIP]
> Wer mag kann hier auch einen Zeitraum wählen nach dem das Zugriffs-Token seine Gültigkeit verliert. Nach Ablauf dieser Zeitspanne ist kein Zugriff auf das Repository durch den Drucker möglich und muss erneuert werden.
3. Zugriffsbereiche wählen
   + Für die Definierung der Zugriffsbereiche nur "workflow" und "read:org" wählen.
4. Abschluss Konfiguration
   + Ganz nach unten scrollen und auf "Generate token" klicken.

![Token-Auswahl](/../main/images/backup7.png)

5. Sicherung des Tokens
   + Nach dem das Token erstellt wurde, befinden wir uns in der Verwaltungsübersicht aller bisher erstellten Tokens.
> [!CAUTION]
> Dies ist der einzige Moment in dem ihr eurer Token auf Github sehen werden! Es ist wichtig, dass das Token entsprechend gesichert wird, da es nicht von Github wiederhergestellt werden kann! Sollte der Zugriff auf dieses Token verloren gehen, muss ein neues erstellt werden. Fall jemand auf die Idee kommen sollte, das Token in Github hochzuladen - vergesst diese Idee. Github erkennt das Token und wird es löschen!

![Token-Auswahl](/../main/images/backup8.png)

Kopiert das Token in die Text-Datei in die ihr die HTTPS-URL euers Repository kopiert habt.

![Token in Notepad](/../main/images/backup9.png)

## **Kombinieren der HTTPS-URL mit dem Token**
Als nächster Schritt müssen Token und URL kombiniert werden.
+ Fügt in der URL hinter den beiden **//** ein **@** ein.
+ Kopiert euren Token in die Zwischenablage und fügt das Token zwischen **//** und dem **@** ein. Das nachfolgende Bild zeigt wie die URL aussehen muss.
> [!NOTE]
>  Nur noch mal zur Erinnerung. Das für diesen Guide erstellte Repository und Token wurden nach Erstellung der Anleitung gelöscht!

![Token+URL](/../main/images/backup10.png)

## ** Verbindung zum Drucker per SSH**
Mit dem Tool euer Wahl per SSH auf den Drucker verbinden. Ich benutze in diesem Guide "Putty"
+ mit folgendem Befehl das Verzeichnis wechseln

  ```bash
  cd ~/printer_data/config
  ```

+ mit nachfolgendem Befehl wird das autocommit-Script heruntergeladen

  ```bash
   wget -O ~/printer_data/config/autocommit.sh https://raw.githubusercontent.com/EricZimmerman/VoronTools/main/autocommit.sh
  ```

+ Als nächstes wird die bevorzugte Weboberfläche ausgewählt. Wer Mainsail benutzt, entfernt die # in der Mainsail-Zeile. Wer Fluidd nutzt entsprechend bei Fluidd. Dafür öffnen wir mit folgendem Befehl die autocommit.sh

  ```bash
   nano ~/printer_data/config/autocommit.sh
  ```
+ Nachfolgendes Bild zeigt die Konfiguration für Mainsail. Fluidd ist entsprechend auskommentiert.

![MainsailoderFluidd](/../main/images/backup11.png)

+ Die autocommit.sh mit STRG+O und danach Enter speichern
+ STRG+X schließt den Editor und wir befinden uns wieder im Pfad "printer_data/config/"
+ Mit nachfolgenden Befehl geben wir uns sowie allen anderen Usern des Systems die Berechtigung die autocommit.sh auszuführen

  ```bash
   chmod +x autocommit.sh
  ```
+ Mit folgenden Befehl prüfen ob die Berechtigungen, wie auf dem nachfolgenden Bild gezeigt, richtig gesetzt sind.
  ```bash
  ls -la autocommit.sh
  ```
![Berechtigungen](/../main/images/backup12.png)
  



