# **Klipper Expander**

# **Disclaimer**
> [!CAUTION]
>Bitte beachtet, dass weder ich noch andere dritte Personen für Schäden an eurem Drucker verantwortlich sind, solltet ihr diesem Tutorial folgen.
>Es müssen Arbeiten mit elektrischen Leitungen vorgenommen werden. Auch wenn wir primär nur mit 24V arbeiten, bei unsachgemäßer Ausführung besteht unteranderem die Gefahr von Kurzschlüssen!

Jeder der einen Drucker der Serie 3 besitzt, wird mitbekommen haben, dass der Mainboardlüfter permanent läuft sobald das Gerät angeschaltet wird.
Hier werden wir ansetzen und Abhilfe schaffen. Qidi hat für die Mainboards X-6 V1.0 mehrere Revisionen veröffentlicht, jedoch nicht nach außen kommuniziert.
So gibt es Mainboards mit einem als FAN2 bezeichneten Lüfterausgang, der sich ansteuern lässt

![Mainboard](/../klipper_expander/images/mainboard_steuerbar.jpeg)

Geräte die an dieser Stelle ein VIN0 haben, fehlt die Möglichkeit diesen Lüfter nach Bedarf steuern zu können. Dieser Lüfter wird immer permanent laufen sobald der Drucker eingeschaltet wird.
Bei näherer Betrachtung keine komfortable Lösung.

Hier kommt nun der Klipper Expander ins Spiel. 
![Mainboard](/../klipper_expander/images/Klipper_Expander.png)

Diese kleine Platine bietet mehrere Möglichkeiten weitere Peripherie hinzuzufügen:
+ 4 3A Mosfet-Ausgänge
+ 2 Thermistor-Eingänge
+ 1 Neopixel-Ausgang mit Pegelverschiebung
+ 1 GPIO-Header
+ I2C-Header mit Pullup-Widerständen

# **Drucker OHNE FAN2**

Für die Realisierung eines steuerbaren Mainboardlüfters benötigen wir folgendes Material
+ 1x Klipper Expander
+ 1x Micro-USB-Kabel mit Datenleitungen
+ 2x Ringkabelschuhe in der Größe 0,5-1,5 mm²
+ 4x Aderendhülsen in der Größe 0,5 mm²
+ 1m Kabel 0,5mm²
+ 1x Crimpzange
+ 1x Lüfter 24V sofern der originale Lüfter nicht verwendet werden soll
+ Schrumpfschlauch, passend für die verwendeten Kabel

# **Vorbereitung Hardware**
+ Als erstes beginnen wir mit den elektrischen Leitungen. Längt entsprechend der Montageposition zwei gleich lange Kabel ab.
+ An das eine Ende kommen die Ringkabelschuhe und an das andere Ende die Aderendhülsen. 
+ Ordendlich crimpen und die Schrumpfschläuche nicht vegessen.


Dreht am Mainboard die Schrauben der Stromversorgung heraus und legt das entsprechende Kabel in den Port
Die auf dem Bild rot markierte Seite ist der stromführende Plus-Pol. Blau ist der Minus-Pol
![Mainboard](/../klipper_expander/images/mainboard.png)

Die Befestigungsschrauben wieder festdrehen.
Die Kabelseite mit den Aderendhülsen in das Anschlussterminal des Klipper Expander einstecken und verschrauben.
Darauf achten, das die Polarität der Anschlüße beachtet wird!

![Mainboard](/../klipper_expander/images/expander_power.png)

## **Anschluß Lüfter**
Nachdem die Stromversorgung des Expander Board abgeschlossen ist, wird der nächste Schritt der Anschluss des Mainboardlüfters sein.
Zuerst den Stecker, sofern vorhanden, des Lüfters abschneiden und mit den beiden restlichen Aderendhüslen vercrimpen.
Die beiden Kabel werden nun in das erste Anschlussterminal der Mosfets verschraubt. Achtet darauf, das auch hier die Polarität beachtet wird.
VIN muss mit Plus und M0 mit dem Minus-Pol verschraubt werden.
![Mainboard](/../klipper_expander/images/expander_mosfet_power.png)

## **Anschluss USB**
Der letzte Schritt ist die Verbindung des Expander Boards mit einem USB-Port des Mainboard
Hier wird ein Typ A auf Micro-USB-Kabel benötigt. 
> [!TIP]
> Unbedingt darauf achten, ein Kabel mit Datenleitungen zu benutzen. Ich habe den Fehler gemacht ein altes Kabel aus der Sammelkiste zu nehmen.
> Dies was ein Kabel zum laden einer USB-Lampe und besaß keine Datenleitungen. Somit war keine Verbindung des Expander zum Mainboard möglich.

# **Flashen des Klipper Expander**

Damit der Drucker mit dem Klipper Expander interagieren kann, muss dieser mit Klipper geflasht werden.
+ Den Drucker hierfür anschalten. Auf dem Klipper Expander sollten mehrere rote LEDs leuchten.
+ Als nächster Schritt muss der Boot-Jumper auf die beiden Boot-PINs gesteckt werden.
+ Reset-Knopf drücken
![Mainboard](/../klipper_expander/images/expander_boot.png)
+ per SSH auf den Drucker verbinden.
+ In der Konsole folgenden Befehl ausführen
```bash
lsusb
```
In der Konsole sollte nun ein STM32-Gerät im DFU-Modus aufgeführt sein.
+ als nächstes folgenden Befehl ausführen
```bash
sudo dfu-util --list
```
+ Den Inhalt dieses Codeblocks notieren [xxxx:yyyy]
+ Mit nachfolgenden Befehl in das Klipper-Verzeichnis wechseln
```bash
cd ~/klipper
```
+ Mit nachfolgenden Befehl das Klipper Configuration Menu öffnen
```bash
make menuconfig
```
+ Alles wie im nachfolgenden Bild einstellen
![Mainboard](/../klipper_expander/images/placeholder.png)
+ Um Speicherplatz zu sparen im Bereich "Optionale Features" folgende Punkte einstellen
![Mainboard](/../klipper_expander/images/placeholder.png)
+ Mit Q die Konfiguration speichern und schliessen
+ Nachfolgenden Befehl zum aufräumen ausführen
```bash
make clean
```
+ Mit dem nächsten Befehl die Firmware flashen. Die xxxx:yyyy durch die mit Befehl dfu-util ausgelesenen Codeblock ersetzen
```bash
make flash FLASH_DEVICE=xxxx:yyyy
```
+ Im nächsten Schritt den Boot Jumper entfernen und danach den Reset-Knopf drücken
+ Folgenden Befehl in der Konsole ausführen
```bash
ls /dev/serial/by-id/*
```
+ Wenn alles richtig geflasht wurde sollte ein Gerät ähnlich diesem angezeigt werden.
```bash
/dev/serial/by-id/usb-Klipper_stm32f042x6_19002A00115330374E333320-if00
```
# **printer.cfg**
Damit der Drucker mit dem Klipper Expander kommunizieren kann müssen folgende Eintragungen in der printer.cfg vorgenommen werden.
Bitte beachten, das hier EURE ID eingetragen werden muss
```bash
[mcu expander]
serial: /dev/serial/by-id/usb-Klipper_stm32f042x6_EURE_ID
restart_method: command
```
Für Zugriff auf den Mainboardlüfter folgenden Code in die Lüfter-Sektion der printer.cfg kopieren
```bash
## Mainboardlüfter
[output_pin mainboard]
pin: expander:PA0
pwm: true
cycle_time: 0.010
value: 0
shutdown_value: 0

[temperature_fan mainboard]
sensor_type: temperature_host
pin: expander:PA0
max_temp: 80.0
target_temp: 35.0
min_temp: 0
shutdown_speed: 0.0
kick_start_time: 0.5
off_below: 0.25
max_speed: 1.0
min_speed: 0.2
control: pid
pid_Kp: 1.0
pid_Ki: 2.5
pid_Kd: 1.0
pid_deriv_time: 4.0
```
In Mainsail wird das dann so angezeigt:

![Mainboard](/../klipper_expander/images/mainboard_temp.png)

# **Weitere Lüfter etc.**
Wer weitere Lüfter einbinden möchte kann diese 3 weiteren Mosfets entsprechend in sein System einbauen
```bash
[output_pin mosfet1]
pin: expander:PA1
pwm: true
cycle_time: 0.010
value: 0
shutdown_value: 0

[output_pin mosfet2]
pin: expander:PA2
pwm: true
cycle_time: 0.010
value: 0
shutdown_value: 0

[output_pin mosfet3]
pin: expander:PA3
pwm: true
cycle_time: 0.010
value: 0
shutdown_value: 0
```
Die beiden zusätzlichen Anschlüsse für Temperaturfühler können so eingefügt werden. In diesem Beispiel sind es 2 Thermistoren die die Temperatur der X und Y-Stepper messen.
```bash
## Thermistor
[thermistor Generic_3950]
temperature1: 25
resistance1: 100000
beta: 3950

## Treiber X
[temperature_sensor Treiber_X]
sensor_type: Generic 3950
sensor_pin: expander:PA6
min_temp: 0
max_temp: 140

## Treiber Y
[temperature_sensor Treiber_Y]
sensor_type: Generic 3950
sensor_pin: expander:PA5
min_temp: 0
max_temp: 140
```

Das einbinden von NeoPixel-LEDs erfolgt mit diesem Block
```bash
# Status LED lights when klipper connects 
[static_digital_output onboardLED]
pins: !expander:PA4


[neopixel expanderPixel]
pin: expander:PB1
chain_count: 1
initial_RED: 0.9
initial_GREEN: 0.3
initial_BLUE: 0.0
```







