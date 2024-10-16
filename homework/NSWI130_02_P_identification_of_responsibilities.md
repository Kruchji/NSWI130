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

##### Zobrazování termínů učiteli

* Zajistit, že databáze poskytne veškerá potřebná data
* Vyznačit konfliktní termíny v rámci času a místnosti

##### Zobrazování formuláře tvorby nového termínu

* Systém musí zobrazit všechna potřebná pole
* Zajistit, že učitel může vytvořit termíny pouze pro jeden z jeho předmětů
* Umožnit výběr seznamu studentů, pro které je tento termín určený

##### Ukládání nových termínů

* Zajistit, že jsou data správně uložena do databáze
* Informovat učitele o úspěšném / neúspěšném vytvoření nového termínu
* Spustit detekci konfliktů na aktualizovaný seznam termínů

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

##### Zobrazenie termínov pre študenta

* Získať zoznam predmetov, ktoré má študent zapísané
* Získať zoznam termínov pre predmety, ktoré má študent zapísané

##### Zobrazenie podrobností pre termín

* Získať informácie pre konkrétny zvolený termín

##### Prihlásenie študenta na konkrétny termín

* Zapísať študenta na konkrétny termín
* Zobraziť úspech/neúspech prihlásenia študentovi

<!-- A ### section for each feature -->
### Feature: Zapis a zmena znamky

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
9) Pre uloženie zmeny klikne učiteľ na tlačidlo Uložiť.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Zobraziť študentov pre konkrétny predmet

* Získať zoznam predmetov, ktoré daný učiteľ vyučuje
* Získať zoznam študentov prihlásených na konkrétny predmet

##### Zapísať známku konkrétnemu študentovi

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

##### Zobrazenie

* Zabezpečiť zobrazenie kalendára s prihlásenými skúškami

<!-- A ### section for each feature -->
### Feature: Odhlásenie zo skúšky

<!-- The feature described in a form of a user story -->
Ako študent chcem mať možnosť odhlásiť sa zo skúšky v danom termíne. Z dôvodu už nevyhovujúceho termínu skúšky, či už z časových, zdravotných alebo iných dôvodov.

#### Feature breakdown

<!-- The feature breakdown -->
1) Student se přihlásí do systému (dashboard) a klikne na tlačítko zobrazení všech zapsaných zkoušek.
2) Systém zde zobrazí v kalendáři nebo seznamu všechny termíny zkoušek, na které se student zapsal.
3) Student klikne na podrobnosti termínu, z kterého se chce odhlásit.
4) Student klikne na tlačítko odhlásit.
5) Systém poté:
    1) Zobrazí oznámení o neúspěšném odhlášení.
    2) Obnoví zobrazení stránky termínu jako když ho student neměl přihlášený a zobrazí oznámení o úspěšném odhlášení z termínu.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Odhlásenie študenta z termínu

* Vymazanie termínu zo zapísaných
* Zobraziť úspech/neúspech odhlásenia študentovi

##### Zobrazenie informácií o termíne

* Získanie zapísaných termínov žiaka
* Získanie informácií o danom termíne

<!-- A ### section for each feature -->
### Feature: Zobrazení informací o zkoušce

<!-- The feature described in a form of a user story -->
Jako student chci mít možnost si zobrazit všechny informace o zkoušce, abych na ní mohl dorazit a úspěšně jí splnit.

#### Feature breakdown

<!-- The feature breakdown -->
1) Žák je na stránce přihlášených zkoušek.
2) Vybere konkrétní zkoušku
3) Zobrazí se stránka s informacemi ke zkoušce
4) Stránka obsahuje základní informace o konání zkoušky: místo, datum, čas, učitel
5) Stránka obsahuje jakékoli další info, které učitel ke zkoušce zapsal: délka trvání, forma zkoušky, speciální požadavky, dresscode, atd.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Práce s databází

* Získání zapsaných termínů žáka
* Získání informací o konkrétním termínu

##### Prezentace

* Zobrazení stránky termínu s informacemi z databáze

<!-- A ### section for each feature -->
### Feature: Úprava informací o zkoušce

<!-- The feature described in a form of a user story -->
Jako učitel potřebuji mít možnost upravit informace o zkoušce a termínech i po jejich vypsání, pokud dojde k nečekaným změnám. Studenti musí býti dostatečně informováni o případných změnách.

#### Feature breakdown

<!-- The feature breakdown -->
1) Po prihlaseni ucitel klikne na policko zobrazeni terminu skousek
2) Po presmerovani ucitel klikne na policko rezervovane terminy, kde najde svuj termin
3) Stranka vyhodi formular s polickami: Predmet, Kapacita, Prerekvizity, (optional) Upresneni casove alokace, (optional) Pridat vypomoc, (optional) vice info
    1) System posle Vypomocnu poziadavku zadaným učitelům, kteří ji najdou na dashboarde v spravach.
4) Po vyplneni a submite stranka spracuje request a upozorni, ci sa ulozily zmeny
5) Stranka presmeruje spatky na polozku rezervovane terminy
6) Studenti, kterých se termín týkal, jsou o změně informování emailem.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Zobrazování termínů

* Získání seznamu termínů z databáze
* Filtrování těchto termínů pro zobrazování pouze těch, které se týkají přihlášeného učitele

##### Posílání notifikace o výpomoci

* Zobrazení notifikace na dashboardě učitelům, od kterých byla vyžádána výpomoc

##### Ukládání změn informací o termínu

* Validace všech vstupů
* Zapsání do databáze
* Detekce konfliktů
* Přesměrování uživatele při úspěšném zapsání

##### Posílání e-mailové notifikace

* Shrnutí všech změn termínu do jedné zprávy
* Získání e-mailových adres všech studentu z databáze, kterých se termín týká
* Úspěšné odeslání e-mailu se změnami všem těmto studentům

<!-- A ### section for each feature -->
### Feature: Zápis na čekací listinu termínu

<!-- The feature described in a form of a user story -->
Jako student bych se rád zapsal do čekací listiny u termínů, které jsou právě plné. Takto nebude třeba aktivně sledovat, zdali se již místo na termínu neuvolnilo. Rád bych byl automaticky zapsán a o této změně notifikován.

#### Feature breakdown

<!-- The feature breakdown -->
1) Po přihlášení student klikne na tlačítko zobrazeni terminu zkoušek
2) Zde student klikne na zobrazení informací o termínu, na jehož čekací listinu se bude chtít zapsat.
3) Na této stránce s informacemi o termínu se zobrazí počet zapsaných a maximální počet studentů.
4) Pokud jsou tyto počty rovné, tak je zobrazeno tlačítko pro zápis na čekací listinu.
5) Kliknutím na něj pošle student požadavek systému pro zapsání do čekací listiny.
6) Student je přesměrován znovu na stránku informací o termínu:
    1) Při úspěchu je zobrazena jeho pozice na čekací listině a tlačítko pro odhlášení z čekací listiny.
    2) Při neúspěchu je zobrazena chybová hláška.

#### Responsibilities

<!-- A ##### section for each group of responsibilities -->

##### Zobrazování termínů

* Získání seznamu termínů z databáze
* Filtrování těchto termínů pro zobrazování pouze těch, které se týkají přihlášeného studenta

##### Zobrazování informací o termínu

* Získání informací o termínu z databáze
* Zobrazení počtu přihlášených studentů
* Případné zobrazení tlačítka přihlášení na čekací listinu

##### Zapisování na čekací listinu

* Zapsání studenta do čekací listiny v databázi
* Zobrazení pozice v této listině na stránce s informacemi o termínu
* Zobrazení chybové hlášky v případě neúspěchu
