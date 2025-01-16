# **Klipper Expander**

Der von Qidi verbaute Mainboardlüfter ist leider aufgrund der Größe von 40mm sehr laut. Dies lässt sich durch den Austausch durch qualitativ bessere und größere Lüfter relativ einfach ändern.
Allerdings hat Qidi mehrere Revisionen der X-6 Mainboards als V1.0 veröffentlich.
Die Geräte, die auf der Anschlussseite einen Port mit der Bezeichnung FAN2 besitzen, können den Mainboardlüfter entsprechend ein oder ausschalten.

![Mainboard](/../klipper_expander/images/mainboard_steuerbar.jpeg)

Geräte die an dieser Stelle ein VIN0 haben, fehlt die Möglichkeit diesen Lüfter nach bedarf steuern zu können. Dieser Lüfter läuft permanent sobald der Drucker eingeschaltet wird.

Hier kommt nun der Klipper Expander ins Spiel. Diese kleine Platine ermöglicht es den Mainboardlüfter seinen Vorstellungen entsprechend zu steueren. 
Dies kann temperaturgesteuert oder drehzahlgesteuert  erfolgen. Beide Möglichkeiten werden später genauer beschrieben.

