# Examinations

## Core features

All core features:
- Vypsání termínu zkoušky
- Zápis studenta na termín zkoušky
- Odhlášení ze zkoušky
- Zobrazení informací o zkoušce
- Úprava informací o zkoušce
- Zápis na čekací listinu
- Zápis a změna známky

See the the list below for a more detailed list of them with their responsibilities.

## Module overview

### Termíny zkoušek

Obsahuje moduly pro pokrytí celé business logiky vypisování a zápisu termínů zkoušek.

Skládá se z:
- Termíny UI
- Termíny Manager
- Konflikt Detektor
- TermínyDB

Featury pokryté moduly:
- Vypsání termínu zkoušky
- Zápis studenta na termín zkoušky
- Odhlášení ze zkoušky
- Zobrazení informací o zkoušce
- Úprava informací o zkoušce
- Zápis na čekací listinu

### Známkování

Obsahuje veškerou logiku pro zajištění zápisů a zobrazování známek studentů.

Skládá se z:
- Známky UI
- Známky Manager
- Známky DB

Zajišťuje featuru:
- Zápis a změna známky

### Notifikator

Obsahuje business logic pro notifikaci uživatelů.

Podílí se na featurách:
- Vypsání termínu zkoušky
- Zápis a změna známky

### Externí moduly

Diagram také obsahuje určité externí moduly, které poskytují informace o osobách a předmětech, popř. zajišťují odesílání notifikací.

Skládá se z:
- Předměty
- Osoby
- Externí notifikátor
