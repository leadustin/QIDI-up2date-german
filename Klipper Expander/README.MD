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






