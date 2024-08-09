# **Filamenttrocknung per Druckbett**

Dieses Macro ermöglicht es über das Druckbett des Qidi Max-3, Plus-3 sowie bauähnliche Drucker feuchtes Filament zu trocknen.
Möglicherweise müssen bei Nicht-QIDI-Druckern die PIN-Belegungen der Lüfter entsprechend angepasst werden. 
Sollte der Drucker keine aktive Bauraumheizung haben, muss auch hier entprechend auskommentiert werden.

Für die eigentliche Trocknung empfiehlt es sich eine entsprechend große Aluminium-Dose zu benutzen, in die man die Filamentrolle legt. Der Boden der Dose sollte plan auf dem Heizbett aufliegen.
Dies erzeugt ein Stauwärme innerhalb der Dose.
Damit feuchte Luft entweichen kann, muss die Dose mit Löchern versehen werden, über die die Luft entweichen kann. Durch geschickte Platzierung der Löcher, kann im Zusammenspiel mit den Lüftern, die Luftzirkulation gewährleistet werden.

# **Disclaimer**
> [!CAUTION]
> Bitte beachtet, dass weder ich noch andere dritte Personen für Schäden an eurem Drucker verantwortlich sind, solltet ihr diesem Tutorial folgen.
> Lasst euren Drucker während des Trocknungsprozess nicht unbeaufsichtigt. Ergreift Brandschutzmaßnahmen wie die Installation einens Brandschutzmelders!

## Installation

Wenn der Drucker entsprechend meines <a href="https://github.com/leadustin/QIDI-up2date-german/blob/main/Klipper-Update/update%2Bupgrade.md">Guides</a> angepasst wurde, kann die Datei trocknung.cfg in den Macros-Ordner kopiert werden.
Danach per include die Datei in der printer.cfg inkludieren
```bash
[include Macros/trocknung.cfg]
```
Die printer.cfg speichern und Klipper neustarten.

Sobald Mainsail die Weboberfläche geladen hat, befinden sich in der Macro-Übersicht 3 neue Macros.
+ START_TROCKNUNG
+ STOP_TROCKNUNG
+ STATUS_TROCKNUNG

STATUS_TROCKNUNG wird durch START_TROCKNUNG automatisch ausgeführt und kann daher im Macros-Konfigurations-Menü ausgeblendet werden.

### Konfiguration und Funktion des Macros START_TROCKNUNG

Über den kleinen Pfeil rechts am Macro-Button öffnet sich das Konfigurations-Menü. Folgende Menüpunkte können konfiguriert werden:
+ Z-Verschiebung des Druckbetts - Wert in mm
+ Bauraum mit Bauraumheizung - Wert in Grad Celsius
+ Heizbett - Wert in Grad Celsius
+ Trocknungsdauer - Wert in Minuten
+ Umluft - Wert in % 
+ Laufzeit_Umluft - Wert in Minuten
+ Wartezeit_Umluft - Wert in Minuten
+ Abluft - Wert in % 
+ Laufzeit_Abluft - Wert in Minuten
+ Wartezeit_Abluft - Wert in Minuten

### Z-Verschiebung des Druckbetts

Bei Ausführung des Macros wird geprüft, ob der Drucker bereits gehomt ist. Nach Überprüfung fährt das Druckbett um den entsprechend im Macro eingestellten Wert nach unten.
Dies ist notwendig, da zwischen Druckkopf und Heizbett die Filamentrolle passen muss.

### Bauraum mit Bauraumheizung

Hier kann die aktive Baumraumheizung konfiguriert werden. Werte werden in Grad Celsius angegeben.

### Druckbett

Der Punkt Druckbett ist für die Temperatur des Druckbetts zuständig. Hier muss darauf geachtet werden, eine dem Filament passende Tempertur zu definieren. 
PLA mit 80 Grad Druckbetttemperatur ist eine schlechte Idee! Der maximale Wert liegt bei 100 Grad Celsius.

### Trocknungsdauer

Die Trocknungsdauer definiert, wie lange der Trocknungsprozess läuft. Werte werden in Minuten angegeben. Derzeit ist die maximale Trocknungsdauer auf 720 Minuten (12 Stunden) konfiguriert.

### Umluft

Unter Umluft wird der seitliche Lüfter konfiguriert. Drehzahlangaben werden in Prozent eingetragen.

### Laufzeit_Umluft

Der Menüpunkt Laufzeit_Umluft definiert wie lange der seitliche Lüfter läuft. Der Wert wird in Minuten eingetragen.

### Abluft

Der Punkt Abluft definiert den Lüfter an der Rückwand des Druckers. Auch hier wird der Wert in Minuten angegeben.

### Laufzeit_Abluft

Hier wird ähnlich der Laufzeit_Umluft die Laufzeit des Abluftlüfters definiert. Werte werden in Minuten eingetragen.

### Wartezeit_Abluft

Hier wird die Wartezeit des Abluftlüfters in Minuten definiert.


## Funktionsweise Lüftersteuerung

Die Lüftersteuerung funktioniert wie folgt. Über Umluft und Abluft wird die Geschwindigkeit beider Lüfter definiert. Ob man beide Lüfter, nur einen oder keinen benutzt, bleibt euch überlassen.
Der Wert "0" schaltet den jeweiligen Lüfter ab.

Die Laufzeiten definieren wie lange der Lüfter aktiv bleibt. In Kombination mit der Wartezeit lassen sich so Intervalle definieren.

### Beispiel Lüfterkonfiguration

Lüfter Abluft ist mit 50% Leistung definiert. Laufzeit ist 10 Minuten und Wartezeit beträgt 30 Minuten. 
Das bedeutet, dass der Lüfter nach 30 Minuten für eine Laufzeit von 10 Minuten mit einer Leistung von 50% aktiviert wird. Nach Ablauf der 10 Minuten beginnt wieder eine Wartezeit von 30 Minuten.
Dies wird solange wiederholt, bis die eingestellte Trocknungsdauer abgelaufen ist oder der Trocknungsprozess manuell gestoppt wurde.
Wird bei Laufzeit und Wartezeit eine "0" eingetragen, laufen die jeweiligen Lüfter permanent bis zum Trocknungsende.

Somit kann zu fest deinierten Zeit feuchte Luft abgesaugt werden oder eine zusätzliche Luftumwälzung erfolgen.

### Konfiguration und Funktion des Macros STOP_TROCKNUNG

Das STOP_TROCKNUNG Macro stoppt nach Ablauf der Trocknungsdauer oder nach manuellem Auslösen die Lüfter, schaltet die Baumraumheizung und das Heizbett aus.

### Statusanzeigen

Das Macro gibt diverse Informationen über M117 (Konsole) und M118 (Display) aus.
Wer die Moonraker Telegram-Erweiterung installiert hat, kann folgende Zeile auskommentieren um eine Benachrichtigung an seinen Telegram-Bot zu erhalten.

+ ;RESPOND PREFIX=tgnotify MSG="Die Filamenttrocknung wurde beendet. Bitte Filament entnehmen."

### Maximal-Werte

Wie zuvor bereits erwähnt sind im Script ein paar Maximalwerte definiert. Das sind wie folgt:

+ Trocknungsdauer = 720 Minuten = 12 Stunden
+ maximale Druckbetttemperatur = 100 Grad Celsius
+ maximale Bauraumtemperatur = 60 Grad Celsius

Wer diese Werte anpassen möchte, kann dies mit diesen Konstanten tun
+ {% set TrocknungsdauerMinuten = 720 %}
+ {% set MaxHeizbettTemperatur = 100.0 %}
+ {% set MaxBauraumTemperatur = 60.0 %}

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/G2G7VMD0W)
