# **Klipper Expander**

Der von Qidi verbaute Mainboardlüfter ist leider aufgrund der Größe von 40mm sehr laut. 
Dies lässt sich durch den Austausch durch qualitativ bessere und größere Lüfter relativ einfach ändern.
Auf den Geräten der Serie 3 läuft dieser Lüfter jedoch permanent so bald der Drucker eingeschaltet wird.
Hier werden wir ansetzen und Abhilfe schaffen. Qidi hat für die Mainboards X-6 V1.0 mehrere Revisionen veröffentlicht, jedoch nicht nach außen kommuniziert.
So gibt es Mainboards mit einem als FAN2 bezeichneten Lüfterausgang, der sich ansteuern lässt

![Mainboard](/../klipper_expander/images/mainboard_steuerbar.jpeg)

Geräte die an dieser Stelle ein VIN0 haben, fehlt die Möglichkeit diesen Lüfter nach Bedarf steuern zu können. Dieser Lüfter läuft permanent sobald der Drucker eingeschaltet wird.
Bei näherer Betrachtung keine komfortable Lösung.

Hier kommt nun der Klipper Expander ins Spiel. 
![Mainboard](/../klipper_expander/images/Klipper_Expander.png)

Diese kleine Platine ermöglicht es den Mainboardlüfter seinen Vorstellungen entsprechend zu steueren. 
Dies kann temperaturgesteuert oder drehzahlgesteuert  erfolgen. Beide Möglichkeiten werden später genauer beschrieben.

# **Benötigtes Material**



