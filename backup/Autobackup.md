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
> [!HINWEIS]
> Solltest du noch keinen Github-Account besitzen, kannst du dir hier einen Account erstellen.
