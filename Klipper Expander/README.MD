# **Klipper Expander**

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

möglicht es den Mainboardlüfter seinen Vorstellungen entsprechend zu steuern. 
Dies kann temperaturgesteuert oder drehzahlgesteuert  erfolgen. Beide Möglichkeiten werden später genauer beschrieben.

# **Benötigtes Material**



