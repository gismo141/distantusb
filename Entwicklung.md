# Entwicklungstagebuch

## 04.04.2014: Test-Auswertung des Bootvorgangs

Mit einem RS-232 auf USB Konverter war es heute möglich den Bootvorgang zu analysieren. Da der Bootvorgang fehlschlägt, war dies eine notwendige Analyse.

### Treiberinstallation

Zur Installation auf Mac ist ein serieller [FTDI][] Treiber notwendig. Anschließend kann mittels `screen` die serielle Verbindung aufgebaut werden. Um die Ausgabe zur weiteren Bearbeitung zu speichern, bietet sich der Befehl `script <dateiname>.<dateiformat>` an. Die Anleitung kann im Internet unter [pixhawk.ethz.ch][] nachgelesen werden.

### Verwendung der Schnittstelle

Die folgende Ausgabe wurde mit dem Code vom aktuellen [picosafe-GIT][] erzeugt. Das zImage wurde mit folgendem Befehl erstellt: `/home/michael/.backup/picosafe/kernel # ./build.sh -k <picosafe>.key`

[pixhawk.ethz.ch]: https://pixhawk.ethz.ch/tutorials/serial_terminal
[FTDI]: http://www.ftdichip.com/Drivers/VCP.htm
[picosafe-GIT]: https://github.com/gismo141/picosafe

### Die Fehleranalyse
 
Die letzten zwei Zeilen der seriellen Übertragung zeigen das Problem. Der Bootloader wird erfolgreich entschlüsselt und die Hardware bereits grundlegend initialisiert. Jedoch findet der Kernel anschließend die `init` nicht im Ordner `/`

`Failed to execute /init`
`Kernel panic - not syncing: No init found.`

## 20.03.2014: Grundlegende Systemvoraussetzungen

### Setup der Virtuellen Maschine

Folgende Pakete müssen installiert werden:

- `GCC` (damit die VMware Tools installiert werden können)
- `Linux-Headers` (linux-headers-$(uname -r))
- `make`
- `git`
- `parted`
- `realpath`
- `libncurses5-dev`

### Bedingungen beim Upload zu GIT

Ausgabe nach `git push -u origin master`:

```shell
Counting objects: 43955, done.
Compressing objects: 100% (39514/39514), done.
Writing objects: 100% (43955/43955), 443.89 MiB | 1.43 MiB/s, done.
Total 43955 (delta 8931), reused 0 (delta 0)
remote: warning: GH001: Large files detected.
remote: warning: See http://git.io/iEPt8g for more information.
remote: warning: File rootfs/picosafe_rootfs/swapfile is 64.00 MB; this is larger than GitHub's recommended maximum file size of 50 MB
remote: warning: File toolchain/eldk-5.2.1/armv5te/sysroots/armv5te-linux-gnueabi/usr/share/doc/qtopia/qch/qt.qch is 56.02 MB; this is larger than GitHub's recommended maximum file size of 50 MB
To https://github.com/gismo141/picosafe.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```

## 28.02.2014: Anpassungen und Analyse

### Samples des Bootvorgangs

Um den Bootvorgang zu samplen, wurden die Einstellungen gemäß vorherigen Ergebnissen eingestellt.

Bus Einstellungen:
- Label `RS-232`
- Baud `115200 `
- Datenbits `8`
- Paritätsbit `None`
- Packets `On`
- Paketende `FF`
- Bus Display `ASCII`

Trigger Menü:
- Typ `Bus`
- Source Bus `B1 (RS-232)`
- Trigger an `Rx Data`
- Trigger auf `APEX` (Hex: `41 50 45 58`)

Anschließend wurde die Messung mit Single gestartet und die Ausgabe auf einem USB-Stick gespeichert.

### Was muss aktuell beim Archiv angepasst werden?

`./common/`:

- Skript ausführbar machen
`$ chmod a+x common.sh`

`./initramfs/`:

- Skript ausführbar machen
`$ chmod a+x geninitramfs.sh`

`./kernel/linux…`:

- Cross-Compiler Umgebung anpassen
`$ vim Makefile`[^1]

[^1]: (Zeile 198) `CROSS_COMPILE   ?= /opt/eldk-5.2.1/armv5te/sysroots/i686-eldk-linux/usr/bin/armv5te-linux-gnueabi/arm-linux-gnueabi-`