# Distant-USB
## Die Vorzüge von USB-Sticks und Cloud-Diensten vereint

In der heutigen Welt ist es wichtig, dass wir unsere privaten Daten vor unberechtigtem Zugriff schützen und dennoch an Bekannte, Freunde und Mitarbeiter verteilen können.
Cloud-Dienste bieten eine akzeptable Basis, scheitern aber meistens im Bereich der Datensicherheit. Ein USB-Stick hingegen ist sehr unhandlich, wenn der Empfänger der Daten weit entfernt ist.

Die in Augsburg ansässige Firma [embedded projects][embedded-projects] hat diesbezüglich in Zusammenarbeit mit der [Universität der Bundeswehr in München][UniBwM] einen sicheren USB-Stick namens [picosafe][] konzipiert. Auf diesem Stick befindet sich ein komplettes `Debian` Betriebssystem, das auf dem internen ARM-Prozessor verschlüsselt ausgeführt wird.

### Was ist [Distant-USB][]?

Um die Vorteile aus Cloud-Diensten und dem USB-Stick zu vereinen, ist das Projekt [Distant-USB][] entstanden. [Distant-USB][] ermöglicht den Zugriff auf entfernte [picosafe][]s per Internet.

### Funktionsprinzip

Der Benutzer kann per Webinterface die gewünschten [picosafe][]s hinzufügen. [Distant-USB][] verbindet sich zu den [picosafe][]s per SSHFS und gibt diese anschließend per SMB über USB an den Host frei.

[Distant-USB][] ist Bestandteil meiner Projekt- und Bachelorarbeit.

[embedded-projects]: https://github.com/embeddedprojects
[UniBwM]: http://www.unibw.de

## Projektstruktur

Das Projekt wird hauptsächlich in C++ geschrieben und mit [Doxygen][Doxygen] dokumentiert. Die entstehende Dokumentation kann unter den [GitHub-Pages][GitHub-Pages] eingesehen werden.

das Projekt kann mit den jeweiligen `Makefiles` und dem korrekt installierten CC kompiliert werden.
Momentan funktioniert die Kompilation nur unter MacOSX und dem CC von [Carlson-Minot][].

**Der aktuelle Status der Projekte [Distant-USB][] und [picosafe][] kann unter dem [Entwicklungstagebuch](docs/Entwicklung.md) eingesehen werden**

[Distant-USB]: https://www.github.com/gismo141/distantusb
[Doxygen]: https://github.com/doxygen/doxygen
[GitHub-Pages]: http://gismo141.github.io/distantusb/
[Eclipse]: http://www.eclipse.org
[Carlson-Minot]: http://www.carlson-minot.com/available-arm-gnu-linux-g-lite-builds-for-mac-os-x
[picosafe]: https://www.github.com/gismo141/picosafe

## Dem Projekt beisteuern

So können Vorschläge dem Projekt beigesteuert werden:

1. [Fork dieses Projekt][fork] in euren Account.
2. [Erstellt einen branch][branch] für die Änderung, die geplant ist.
3. **Macht die Änderungen in eurem fork.**
4. [Sende eine pull-Anfrage][pr] von eurem fork’s branch zu meinem `master` branch.

Die Benutzung des web-basierten Interfaces, um Änderungen zu tätigen, ist ebenfalls möglich und hilft die oben genannten Vorschläge zu automatisieren.

[fork]: http://help.github.com/forking/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository
[pr]: http://help.github.com/pull-requests/