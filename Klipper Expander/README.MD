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

# **Anschluß Lüfter**
Nachdem die Stromversorgung des Expander Board abgeschlossen ist, wird der nächste Schritt der Anschluss des Mainboardlüfters sein.
Zuerst den Stecker, sofern vorhanden, des Lüfters abschneiden und mit den beiden restlichen Aderendhüslen vercrimpen.
Die beiden Kabel werden nun in das erste Anschlussterminal der Mosfets verschraubt. Achtet darauf, das auch hier die Polarität beachtet wird.
VIN muss mit Plus und M0 mit dem Minus-Pol verschraubt werden.
![Mainboard](/../klipper_expander/images/expander_mosfet_power.png)

# **Anschluss USB**
Der letzte Schritt ist die Verbindung des Expander Boards mit einem USB-Port des Mainboard
Hier wird ein Typ A auf Micro-USB-Kabel benötigt. 
> [!CAUTION]
> Unbedingt darauf achten, ein Kabel mit Datenleitungen zu benutzen. Ich habe den Fehler gemacht ein altes Kabel aus der Sammelkiste zu nehmen.
> Dies was ein Kabel zum laden einer USB-Lampe und besaß keine Datenleitungen. Somit war keine Verbindung des Expander zum Mainboard möglich.

# **Flashen des Klipper Expander**

Damit der Drucker mit dem Klipper Expander interagieren kann, muss dieser mit Klipper geflasht werden.
+ Den Drucker hierfür anschalten. Auf dem Klipper Expander sollten mehrere rote LEDs leuchten.
+ Als nächster Schritt muss der Boot-Jumper auf die beiden Boot-PINs gesteckt werden.
+ Reset-Knopf drücken
![Mainboard](/../klipper_expander/images/expander_boot.png)
+ per SSH auf den Drucker verbinden. 
```bash
lsusb
```
In der Konsole sollte nun ein STM32-Gerät im DFU-Modus aufgeführt sein.
+ als nächstes folgenden Befehl ausführen
```bash
sudo dfu-util --list
```







