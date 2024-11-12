workspace "SIS Exams Workspace" "Tento workspace dokumentuje architekturu systému správy zkoušek a známek v rámci Studijního informačního systému." {

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky" {

            Group "Termíny zkoušek" {
                TerminyUI = container "Termíny UI" "Zobrazí UI na termíny pre učitele a študenty" "" "Web Front-End"
                TerminyManager = container "Termíny Manager" "Rieši veci okolo termínov (vnútorné členenie na minimálne čakačku a prihlasovanie); posiela notifikácie pri zmenách; komunikuje s DB" {
                    CekaciListinaController = component "Čekací Listina Controller" "Prihlásenie na čakaciu listiny; Odhlásanie z čakacej listiny"
                    HlaseniNaTerminyController = component "Hlášení na termíny Controller" "Prihlásenie na termín; Odhlásenie z termínu"
                    TerminyDataController = component "Termíny Data Controller" "Vytvorenie termínu; Úprava termínu"
                    TerminyDBController = component "Termíny DB Controller" "Komunikácia s databázou na termíny"
                    TerminySyncer = component "Synchronizácia termínov" "Posiela informácie o zmenách v termínoch pre použitie v ZnamkyDB"
                }
                TerminyDB = container "TermínyDB" "Ukladá info o termínoch, prihlásených studentech, čakajúcich studentech" "" "Database"
                KonfliktDetektor = container "Konflikt Detektor" "Volá ho termíny manager, detekuje konflikty, reportuje stav termíny UI" {
                    KonfliktDetektorDBController = component "DB Controller" "Získava informácie o termínoch z databázi"
                    KonfliktDetektorFinder = component "Hľadač konfliktov" "Hľadá konflikty v termínoch"
                    KonfliktDetektorReporter = component "Reporter konfliktov" "Komunikuje s notifikátorom o výsledkoch"
                }
            }
            
            Group "Známkování" {
                ZnamkyUI = container "Známky UI" "Zobrazí UI na známky pre učitele a študenty" "" "Web Front-End"
                ZnamkyManager = container "Známky Manager" "Rieši veci okolo známok (zapisovanie, pozeranie, ...); posiela notifikácie pri zmenách; treba spojeni so známky managerom pre prípad, že termín vyžaduje zápočet; komunikuje s DB" {
                    ZnamkyDataController = component "Známky Data Controller" "Čte a zapisuje známky, při změně žádá o notifikaci"
                    ZnamkyDBController = component "Známky DB Controller" "Komunikácia s databázou na známky"
                    ZnamkySyncer = component "Synchronizuje termíny" "Vytvára nové termíny v DB, ukladá informácie o prihlásených termínoch študenta"
                }
                ZnamkyDB = container "Známky DB" "Ukladá hodnotenie študenta aj s históriou v rámci jedného predmetu" "" "Database"
            }
            
            Osoby = container "Osoby" "Externí modul pre osoby (extra info o nich, ...)" "" "Existing System"
            Predmety = container "Predmety" "Externí modul pre predmety (aktuálne zapísané pre študenty, história, ...)" "" "Existing System"
            Notifikator = container "Notifikator" "Vytvára notifikácie (po obsahovej stránke čiže nejaké templaty); emaily, notifikácie do UI; (umožnění učitelům upravit obsah => treba napojiť na UI)" {
                GeneratorObsahuSprav = component "Generátor obsahu správ" "Vytvorenie obsahu správy podla templatu"
                TemplateManager = component "Template Manager" "Spravovanie a poskytovanie templatov pre notifikácie"
                NotifikacieDispatcher = component "Notifikácie Dispatcher" "Komunikácia s externým modulom pre notifikácie"
                NotifikacieController = component "Notifikácie Controller" "Komunikuju s ním Terminy Manager a Znamky Manager; Spúšťa tvorbu notifikácie"
            }            
            ExtNotif = container "Ext. notif." "Externí modul na notifikácie a centrálnym mail serverom systému" "" "Existing System"
        }

        SIS = softwareSystem "SIS" "Spravuje data veci, co se dejou na univerzite. Vcetne zkousek, predmetu a zapisu." "Existing System"

        # actors
        ucitel = person "Učitel" "Vytvari terminy na zkousky a zapisuje hodnoceni"
        student = person "Student" "Zapisuje si terminy zkousek a diva se jak dopadli"
        manazer = person "Manažer" "Dela statistiky a spravuje vyucujici"

        # relationships between users and Exams system
        ucitel -> SISExams "Zobrazení termínu"
        ucitel -> SISExams "Vytvari terminy a zapisuje znamky"
        student -> SISExams "Čte výsledky zkoušek"
        student -> SISExams "Zapisuje si zkoušky"
        manazer -> SISExams "Čte statistiky"

        ucitel -> TerminyUI "Vytváří a zobrazuje termíny"
        ucitel -> ZnamkyUI "Zapisuje známky"
        student -> ZnamkyUI "Čte výsledky zkoušek"
        student -> TerminyUI "Zapisuje si zkoušky"
        manazer -> TerminyUI "Zobrazuje statistiky"
        manazer -> ZnamkyUI "Zobrazuje statistiky"

        # Relationships between SW Systems
        SISExams -> SIS "API na zistení a zápis dat"

        # Relationships inside SISExams
        TerminyUI -> TerminyManager "Získává data o termínech"
        TerminyUI -> TerminyManager "Posílá žádosti o přihlášení / odhlášení / vytvoření termínu"
        TerminyManager -> TerminyDB "Ukladanie termínov"
        KonfliktDetektor -> TerminyUI "Posiela výsledky detekcie konfliktov"
        KonfliktDetektor -> TerminyDB "Číta informácie o termínoch"
        TerminyManager -> KonfliktDetektor "Volá detekciu konfliktov"
        TerminyManager -> Notifikator "Pri zmene/pridani terminu žiada o poslanie notifikacie"
        TerminyUI -> Osoby "Zobrazí studenty na termínu"
        TerminyUI -> Osoby "Zobrazí zkoušející učitele na termínu"
        TerminyUI -> Predmety "Získá seznam vybraných předmětů"
        TerminyUI -> Predmety "Získá informace o předmětu"
        ZnamkyUI -> ZnamkyManager "Pri zmene známky žiada o poslanie notifikacie"
        ZnamkyUI -> ZnamkyManager "Získává data o známkách"
        ZnamkyUI -> ZnamkyManager "Posílá žádosti o změny známek"
        ZnamkyUI -> Osoby "Zobraziť študentovi jeho hodnotenie"
        ZnamkyUI -> Osoby "Zobrazit ucitelovi tabulku s hodnotenim studentov"
        ZnamkyUI -> Predmety "Získá seznam vybraných předmětů"
        ZnamkyUI -> Predmety "Získá informace o předmětu"
        ZnamkyManager -> ZnamkyDB "Zapísať / Zmeniť hodnotenie"
        ZnamkyManager -> Notifikator "Posiela notifikácie pri zmene známky"
        Notifikator -> ExtNotif "Posiela hotové notifikácie na odoslanie"
        TerminyManager -> ZnamkyManager "Synchronizuje termíny medzi DB"

        # Relationships inside ZnamkyManager
        ZnamkyDataController -> ZnamkyDBController "Ukladá známky / Získava známky"
        ZnamkyDataController -> Notifikator "Posiela žiadosť o notifikáciu"
        ZnamkyDBController -> ZnamkyDB "Ukladá zmeny do databáze / číta DB"
        ZnamkyUI -> ZnamkyDataController "Posiela žiadosti o zmenu známky / získava informácie o známkach"
        TerminyManager -> ZnamkySyncer "Príjma informácie z termínov"
        ZnamkySyncer -> ZnamkyDB "Ukladá dáta do DB"

        #Relationships inside Notifikator
        TerminyManager -> NotifikacieController "Posiela žiadosť o notifikáciu"
        ZnamkyManager -> NotifikacieController "Posiela žiadosť o notifikáciu"
        TemplateManager -> GeneratorObsahuSprav "Načítá šablóny pre generaciu obsahu"
        GeneratorObsahuSprav -> NotifikacieDispatcher "Poskytne obsah správy na poslanie"
        NotifikacieController -> TemplateManager "Požiada o použitie daného templatu pre správu"
        NotifikacieController -> NotifikacieDispatcher "Poskytne získanú adresu z Osoby modulu"
        NotifikacieController -> GeneratorObsahuSprav "Poskytne info o termine/znamke ktoré sú obsahom správy"
        NotifikacieDispatcher -> ExtNotif "Poskytuje všetky info na na odoslanie notifikacie"

        #Relationships inside TerminyManager
        TerminyDataController -> Notifikator "Žiada o zaslanie notifikacie o termine"
        TerminyDataController -> TerminyDBController "Ukladá termíny; Získava info o termínoch"
        TerminyDataController -> KonfliktDetektor "Volá ohľadom kontroly termínu"
        TerminyUI -> TerminyDataController "Posiela žiadosti na nový termín / prihlásenie/odhlásenie žiaka / Žiada data o termínoch"
        HlaseniNaTerminyController -> TerminyDBController "Ukladá info o prihásených studentoch"
        CekaciListinaController -> TerminyDBController "Ukladá info o studentoch na čakacej listine"
        TerminyDBController -> TerminyDB "Ukladá zmeny do databáze / číta DB"
        TerminyDataController -> TerminySyncer "Posiela nové termíny"
        HlaseniNaTerminyController -> TerminySyncer "Posiela informácie o prihlásených/odhlásených študentoch"
        TerminySyncer -> ZnamkyManager "Posiela informácia pri vytvorení nových termínov a prihlásení/odhlásení študentov"

        # Relationships inside KonfliktDetektor
        TerminyManager -> KonfliktDetektorFinder "Volá hľadanie konfliktov"
        KonfliktDetektorFinder -> KonfliktDetektorDBController "Získava dáta o termínoch"
        KonfliktDetektorDBController -> TerminyDB "Číta dáta o termínoch z DB"
        KonfliktDetektorFinder -> KonfliktDetektorReporter "Posiela výsledky hľadania konfliktov"
        KonfliktDetektorReporter -> TerminyUI "Posiela výsledky detekcie konfliktov"
    }

    views {
        systemContext SISExams "SISExamsSystemDiagram" {
            include *
        }

        container SISExams "SISExamsContainerDiagram" {
            include *
        }

        component TerminyManager "TerminyManagerComponentDiagram" {
            include *
            exclude ZnamkyManager->*
            exclude KonfliktDetektor->*
        }

        component ZnamkyManager "ZnamkyManagerComponentDiagram" {
            include *
            exclude TerminyManager->Notifikator
        }

        component Notifikator "NotifikatorComponentDiagram" {
            include *
            exclude TerminyManager->ZnamkyManager
        }

        component KonfliktDetektor "KonfliktDetektorComponentDiagram" {
            include *
            exclude TerminyUI->TerminyManager
            exclude TerminyManager->TerminyDB
        }

        theme default

        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Database" {
                background #8243d5
                shape Cylinder
            }
            element "Web Front-End" {
                background #8ad543
                shape WebBrowser
            }
        }
    }

}
