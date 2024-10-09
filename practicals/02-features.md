### Vypisovani terminu
**Ucitel**: informacie pre ziakov na splnenie predmetu

**MVP**: bez vypísania podmienok na splnenie termínu študenti nevedia ako budú hodnotení, preto môže byť ich príprava nedostatočná a následne viesť k nesplneniu predmetu, čo nie je v záujme študentov a aj vyučujúcich

**Steps**:
1) Učiteľ v dashboarde si zobrazí zoznam všetkých termínov.
2) Následne klikne na tlačítko vyplniť základné informácie o skúške.
3) Systém mu zobrazí formulár, tam učiteľ zadá kód predmetu, formu skúšky (písomná, ústna, ústna s písomnou prípravou, prípadne iná), vyplní text s popisom hodnotenia, či sa jedná o zápočet alebo skúšku, prípadne iné požiadavky (doniesť si vlastný počítač a pod )
4) Ak sa jedná o skúšku
  a) Môže zvoliť, či študent musí mať zápočet pred prihlásením
  b) Vyplniť text o možnosti opravenia si známky
5) Ak sa jedná o zápočet
  a) Mal by špecifikovať, pre ktorých študentov je tento termín určený
6) Po kliknutí na tlačítko uložiť, systém spracuje jeho požiadavky a zobrazí učiteľovi správu o stave (úspech/neúspech)
7) Následne ho presmeruje na na zobrazenie všetkých termínov

### Zapis studentu
**Student**: aby mohol splnit predmet

**MVP**: Neboť je to základní feature, která umožňuje elektronické zapisování na termíny a jednoduché zobrazení všech dostupných termínů.

**Steps**:
1) Student se přihlásí do systému (dashboard) a klikne na tlačítko zobrazení všech termínů zkoušek.
2) Systém zde zobrazí v kalendáři nebo seznamu všechny dostupné termíny zkoušek pro předměty, které má student zapsané.
3) Student zde může vyfiltrovat určitý předmět.
4) Student vybere určitý termín a klikne na jeho podrobnosti.
5) Systém zobrazí podrobné informace o předmětu s tlačítkem pro zápis.
6) Student klikne na tlačítko zápis pro zapsání tohoto termínu.
7) Systém poté:
 a) Vrátí studenta na seznam všech termínů s hláškou úspěšného zapsání.
 b) Vrátí studenta na seznam všech termínů s hláškou úspěšného zapsání na čekací listinu.
 b) Vypíše chybu při zapisování a vrátí studenta na podrobnosti termínu.

### Zapis a zmenu znamky
**Ucitel**: informovat o vysledku a napravil chyby

**MVP**: Dôležité pre správne fungovanie systému. Študent je oboznámený s výsledkom a vyučujúci vie koľko ľudí už prešlo skúškou.

**Steps**:
1) Učiteľ sa prihlási do systému a klikne na tlačidlo predmety. 
2) V časti predmety zo zoznamu svojich vyučovaných predmetov vyberie ten, z ktorého chce známku zapísať/zmeniť.
3) Učiteľovi sa zobrazí zoznam prihlásených žiakov na vybraný predmet.
4) Učiteľ do poľa vyhľadať napíše meno žiaka, ktorému chce známku zapísať.
5) Vo výsledkoch vyhľadávania klikne na žiaka.
6) Otvoria sa výsledky žiaka z daného predmetu. 
7) V poli známka stlačí tlačidlo upraviť.
8) Do zobrazeneho poľa vpíše známku.
9) pre uloženie zmeny klikne učiteľ na tlačidlo Uložiť. 

### Statistika:
**Manazer**: Aby mohol urobit pripadne zmeny

### Validacia zapoctu:
**Ucitel**: Aby vedel, ci ziak splna podmienky

### Odhlaseni zmena
**Ziak**: Zmena rozhodnutia ziaka

### Cakacka
**Ziak**: Prihlasenie na potencialny termin

### Notifikacie
**Ziak**: Aby ziak vedel, ze sa moze zapisat

### Info
**Ziak**: Informacie, aby ziak mohol ist na skusku pripraveny

**MVP**: key feature for student so they have knowledge about the exam and can arrive on the right time at the right place

**Steps**:
1) Žák je na stránce přihlášených zkoušek.
2) Vybere konkrétní zkoušku
3) Zobrazí se stránka s informacemi ke zkoušce
4) Stránka obsahuje základní informace o konání zkoušky: místo, datum, čas, učitel
5) Stránka obsahuje jakékoli další info, které učitel ke zkoušce zapsal: délka trvání, forma zkoušky, speciální požadavky, dresscode, atd.

### Rezervacie
**Ucitel**: Aby neboli konflikty pri terminom miestnosti

**MVP**: Ucitel potrebuje, aby si rezervoval termin na zkousku. Ma problemy s tim, ze ostatni ucitele si muzou zarezervovat stejnou mistnost a cas. Tahle feature slouzi, aby se ucitele nemuseli domlouvat, ale vedeli, ze kdyz si zapisou cas, tak nikdo jiny jim ho nezebere.

**Steps**:
1) Učitel po přihlášení do dashboard klikne na zobrazení všech termínů zkoušek.
2) Učitel klikne na tlačítko rezervace nového termínu.
3) Systém zobrazí formulář s prázdným seznamem termínů.
4) Učitel pomocí plus vytvoří nový termín/y.
5) Ve formuláři vyplní čas a budovu.
6) Po potvrzení systém
 a) Zobrazí zarezervované termíny.
 b) Zobrazí konflikty místnosti + času.

### Zapis informacii
**Ucitel**: Vyplneni informacie o terminu

**MVP**: bez tejto funkcionality ucitel nebude vediet pridat dolezite info o skuske, co sposobi nedostatok informacii pre studenta ohladom zapisanej skusky.

**Steps**:
1) Po prihlaseni ucitel klikne na policko zobrazeni terminu skousek
2) Po presmerovani ucitel klikne na policko rezervovane terminy, kde najde svuj termin
3) Stranka vyhodi formular s polickami: Predmet, Kapacita, Prerekvizity, (optional) Upresneni casove alokace, (optional) Pridat vypomoc, (optional) vice info
 a) System posle Vypomocnu poziadavku ucitelovi, ktory ju najde na dashboarde v spravach.
4) Po vyplneni a submite stranka spracuje request a upozorni, ci sa ulozily zmeny
5) Stranka presmeruje spatky na polozku rezervovane terminy

### Rozdelovanie studentov
**Ucitel**: Alokacie medzi ucitelov a casy
