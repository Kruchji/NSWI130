# Studijní informační systém (EXA 1)

## Core features and responsibilities

<!-- A ### section for each feature -->
### Feature: Vypisovani terminu

<!-- The feature described in a form of a user story -->
Jako učitel chci mít možnost vypisovat termíny zkoušek pro všechny své předměty, aby studenti dostali všechny potřebné informace o jednotlivých termínech a mohli se na libovolný z nich zapsat.

#### Feature breakdown

<!-- The feature breakdown -->
1) Učiteľ v dashboarde si zobrazí zoznam všetkých termínov.
2) Následne klikne na tlačítko vyplniť základné informácie o skúške.
3) Systém mu zobrazí formulár, tam učiteľ zadá kód predmetu, formu skúšky (písomná, ústna, ústna s písomnou prípravou, prípadne iná), vyplní text s popisom hodnotenia, či sa jedná o zápočet alebo skúšku, prípadne iné požiadavky (doniesť si vlastný počítač a pod )
4) Ak sa jedná o skúšku
    1) Môže zvoliť, či študent musí mať zápočet pred prihlásením
    2) Vyplniť text o možnosti opravenia si známky
5) Ak sa jedná o zápočet
    1) Mal by špecifikovať, pre ktorých študentov je tento termín určený
6) Po kliknutí na tlačítko uložiť, systém spracuje jeho požiadavky a zobrazí učiteľovi správu o stave (úspech/neúspech)
7) Následne ho presmeruje na na zobrazenie všetkých termínov

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Responsibilities 1

* Integrate...
* Ensure...

##### Responsibilities 2

* Run...

<!-- A ### section for each feature -->
### Feature: Zapis studentu

<!-- The feature described in a form of a user story -->
Ako študent chcem úspešne dokončiť predmet a preto chcem mať možnosť sa zapísať na vypísané termíny skúšok a zápočtov.

#### Feature breakdown

<!-- The feature breakdown -->
1) Student se přihlásí do systému (dashboard) a klikne na tlačítko zobrazení všech termínů zkoušek.
2) Systém zde zobrazí v kalendáři nebo seznamu všechny dostupné termíny zkoušek pro předměty, které má student zapsané.
3) Student zde může vyfiltrovat určitý předmět.
4) Student vybere určitý termín a klikne na jeho podrobnosti.
5) Systém zobrazí podrobné informace o předmětu s tlačítkem pro zápis.
6) Student klikne na tlačítko zápis pro zapsání tohoto termínu.
7) Systém poté:
    1) Vrátí studenta na seznam všech termínů s hláškou úspěšného zapsání.
    2) Vrátí studenta na seznam všech termínů s hláškou úspěšného zapsání na čekací listinu.
    3) Vypíše chybu při zapisování a vrátí studenta na podrobnosti termínu.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Práca s databázou

* Získať zoznam predmetov, ktoré má študent zapísané
* Získať zoznam termínov pre predmety, ktoré má študent zapísané
* Získať informácie pre konkrétny zvolený termín
* Zapísať študenta na konkrétny termín

<!-- A ### section for each feature -->
### Feature: Zapis a zmenu znamky

<!-- The feature described in a form of a user story -->
Ako učiteľ chcem mať možnosť informovať študentov o získanej známke prípadne zápočte cez informačný systém. V prípade omylu na mojej strane alebo opravenia si známky študenta následne opraviť pôvodne zapísanú známku/zápočet.

#### Feature breakdown

<!-- The feature breakdown -->
1) Učiteľ sa prihlási do systému a klikne na tlačidlo predmety.
2) V časti predmety zo zoznamu svojich vyučovaných predmetov vyberie ten, z ktorého chce známku zapísať/zmeniť.
3) Učiteľovi sa zobrazí zoznam prihlásených žiakov na vybraný predmet.
4) Učiteľ do poľa vyhľadať napíše meno žiaka, ktorému chce známku zapísať.
5) Vo výsledkoch vyhľadávania klikne na žiaka.
6) Otvoria sa výsledky žiaka z daného predmetu.
7) V poli známka stlačí tlačidlo upraviť.
8) Do zobrazeneho poľa vpíše známku.
9) pre uloženie zmeny klikne učiteľ na tlačidlo Uložiť.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Práca s databázou

* Získať zoznam predmetov, ktoré daný učiteľ vyučuje
* Získať zoznam študentov prihlásených na konkrétny predmet
* Zápisať konkrétnemu študentovi zvolenú známku

### Feature: Notifikácie

<!-- The feature described in a form of a user story -->
Ako žiak chcem byť oboznámený notifikáciou v prípade, že je vypísaný nový termín z predmetu, ktorý mám zapísaný. Aby som sa mohol na ne zapísať a poprípade preplánovať iné skúšky.

#### Feature breakdown

<!-- The feature breakdown -->
1) Keď systém detekuje, že učiteľ vypísal nový termín daného predmetu, systém vyhľadá žiakov zapísaných na daný predmet a pošle im informáciu o novom termíne.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Notifikačné responsibilities

* Detekcia pridania nového termínu
* Vygenerovanie emailu
* Zaslanie emailu s informáciami o termíne

<!-- A ### section for each feature -->
### Feature: Odhlásenie zo skúšky

<!-- The feature described in a form of a user story -->
Ako študent chcem mať možnosť odhlásiť sa zo skúšky v danom termíne. Z dôvodu už nevyhovujúceho termínu skúšky, či už z časových, zdravotných alebo iných dôvodov.

#### Feature breakdown

<!-- The feature breakdown -->
1) Student se přihlásí do systému (dashboard) a klikne na tlačítko zobrazení všech zapsaných skoušek.
2) Systém zde zobrazí v kalendáři nebo seznamu všechny termíny zkoušek, na které se student zapsal.
3) Student klikne na podrobnosti termínu, z kterého se chce odhlásit.
4) Student klikne na tlačítko odhlásit.
5) Systém poté:
    1) Zobrazí oznámení o neúspěšném odhlásení.
    2) Obnoví zobrazení stránky termínu jako když ho student neměl přihlásený a zobrazí oznámení o úspěšném odhlásení z termínu.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Práce s databází

* Získanie zapísaných termínov žiaka
* Získanie informácií o termíne
* Vymazanie termínu zo zapísaných
