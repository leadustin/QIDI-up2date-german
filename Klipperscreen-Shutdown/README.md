# **Shutdown Klipperscreen**
> [!NOTE]
> Dieses Macro bringt nur etwas, wenn ihr den im [Total-Umbau](Klipper-Update/update+upgrade.md) beschriebenen Weg bzgl. des Display-Tauschs befolgt habt! 
## **Installation eines Makros um den Raspberry, auf dem Klipperscreen läuft, per Makro herunterzufahren.**

Mit diesem Makro lässt sich der Raspberry Pi bequem aus Mainsail herunterfahren. Dies ist nützlich wenn der Drucker vom PC entfernt aufgestellt ist.
Die Stromversorgung läuft bei mir über einen Smartplug von Ikea und ist per Alexa eingebunden. Der Drucker steht im Keller und wird somit bequem per App oder Sprachbefehl ausgeschaltet. Andere Smartplugs funktionieren ebenfalls.
Da abrupte Stromunterbrechungen für die SD-Karte des Pis nicht zu empfehlen sind, lässt sich mit dem Makro der Raspberry  und in Mainsail der Drucker-Host sicher herunterfahren.

![Klipperscreenshutdown](/../main/images/klippershutdown1.png)

Die eigentliche Installation ist simpel. Kopiert die klipperscreen_shutdown.cfg und die klipperscreen_shutdown.sh und ladet sie auf euren Drucker.
Wenn ihr das Tutorial für das automatsiche Github-Backup befolgt habt, befindet sich auf dem Drucker ein Ordner mit der Bezeichnung "Scripts". In diesen Ordner wird das Script kipperscreen_shutdown.sh kopiert.
Wurde der Guide für das Total-Update befolgt, befindet sich auf dem Drucker auch ein Ordner mit der Bezeichnung "Macros" Kopiert dort die klipperscreen_shutdown.cfg.

## **Konfigurations klipperscreen_shutdown.sh**
+ Öffnet nun in Mainsail die klipperscreen_shutdown.sh und passt die IP des Druckers und falls ihr einen anderen User/Passwort benutzt, entsprechend diesen Abschnitt an eure Daten an.
+ Als nächstes muss dem Script die Berechtigung zum ausführen gegeben werden. Führt folgenden Befehl in Putty aus. Alternativ kann auch in WinSCP die Berechtigung gesetzt werden. Siehe nachfolgendes Bild.
  
  ```bash
  chmod 0755 ~/printer_data/config/Scripts/klipperscreen_shutdown.sh
  ```
+ die Datei klipperscreen_shutdown.sh per Rechtsklick markieren, dann Eigenschaften und dann wie im Bild entsprechend die Häkchen setzen.

![CHMOD](/../main/images/chmod1.png) 

Falls ihr Änderungen an dieser Datei in Mainsail vornehmt, müsst ihr die Berechtigungen wieder neu vergeben. Bei Änderungen über WinSCP bleiben diese bestehen.

## **Konfiguration klipperscreen_shutdown.cfg**
+ Entsprechend des Speicherorts der Datei müsst ihr den Pfad zur klipperscreen_shutdown.sh definieren. Habt ihr meine anderen Guides befolgt, muss hier nichts geändert werden.

## **Konfiguration printer.cfg**
+ Der letze Punkt ist das inkludieren der klipperscreen_shutdown.cfg in die printer.cfg
+ Kopiert folgenden Text am Beginn der printer.cfg unter alle anderen Includes

```bash
[include Macros/klipperscreen_shutdown.cfg]
```
+ Die printer.cfg speichern und Klipper neustarten.
+ In der Macro-Sektion befindet sich nun folgendes Macro:

![Macro](/../main/images/klippershutdown2.png) 

+ Beim Klick auf das Makro wird eine SSH-Verbindung zum Raspberry Pi aufgebaut und dieser heruntergefahren. Nachfolgend ein Screen der Konsole in Mainsail.

![Konsole](/../main/images/klippershutdown3.png) 

Falls dir dieser Guide gefallen hat:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/G2G7VMD0W)

