workspace "SIS Exams Workspace" "Tento workspace dokumentuje architekturu systému správy zkoušek a známek v rámci Studijního informačního systému." {

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky" {

            Group "Termíny zkoušek" {
                TerminyUI = container "Termíny UI" "Zobrazí UI na termíny pre učitele a študenty" "" "Web Front-End"
                TerminyManager = container "Termíny Manager" "Rieši veci okolo termínov (vnútorné členenie na minimálne čakačku a prihlasovanie); posiela notifikácie pri zmenách; komunikuje s DB" {
                    CekaciListinaController = component "Čekací Listina Controller" "Príhlasenie na čakaciu listiny; Odhlásanie z čakacej listiny"
                    HlaseniNaTerminyController = component "Hlášení na termíny Controller" "Prihlásenie na termín; Odhlásenie z termínu"
                    TerminyDataController = component "Termíny Data Controller" "Vytvorenie termínu; Úprava termínu"
                }
                TerminyDB = container "TermínyDB" "Ukladá info o termínoch, prihlásených studentech, čakajúcich studentech" "" "Database" {
                    TerminyInfoSaver = component "Termíny Info Saver" "Ukladanie termínov; Uložiť prihlásenie na termín; Uložiť odhlásenie z termínu; Uložiť prihlásenie na čak. listinu; Uložiť odhlásenie z čak. listiny"
                    TerminyInfoProvider = component "Termíny Info Provider" "Poskytnúť informácie o termíne"
                }
                KonfliktDetektor = container "Konflikt Detektor" "Volá ho termíny manager, detekuje konflikty, reportuje stav termíny UI"
            }
            
            Group "Známkování" {
                ZnamkyUI = container "Známky UI" "Zobrazí UI na známky pre učitele a študenty" "" "Web Front-End"
                ZnamkyManager = container "Známky Manager" "Rieši veci okolo známok (zapisovanie, pozeranie, ...); posiela notifikácie pri zmenách; treba spojeni so známky managerom pre prípad, že termín vyžaduje zápočet; komunikuje s DB" {
                    ZnamkyDataController = component "Známky Data Controller" "Čte a zapisuje známky, při změně žádá o notifikaci"
                }
                ZnamkyDB = container "Známky DB" "Ukladá hodnotenie št aj s históriou v rámci jedného predmetu" "" "Database"
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

        # Relationships between SW Systems
        SISExams -> SIS "API na zistení a zápis dat"

        # Relationships inside SISExams
        TerminyUI -> TerminyManager
        TerminyManager -> TerminyDB "Ukladanie termínov"
        KonfliktDetektor -> TerminyUI
        KonfliktDetektor -> TerminyDB
        TerminyManager -> KonfliktDetektor
        TerminyManager -> Notifikator "Pri zmene/pridani terminu žiada o poslanie notifikacie"
        TerminyUI -> Osoby
        TerminyUI -> Predmety
        ZnamkyUI -> ZnamkyManager "Pri zmene známky žiada o poslanie notifikacie"
        ZnamkyUI -> Osoby "Zobraziť študentovi jeho hodnotenie"
        ZnamkyUI -> Osoby "Zobrazit ucitelovi tabulku s hodnotenim studentov"
        ZnamkyUI -> Predmety
        ZnamkyManager -> ZnamkyDB "Zapísať / Zmeniť hodnotenie"
        Notifikator -> Osoby "Získanie e-mailových adries"
        ZnamkyManager -> Notifikator
        Notifikator -> ExtNotif
        
        # Relationships inside ZnamkyManager
        ZnamkyDataController -> ZnamkyDB
        ZnamkyDataController -> Notifikator

        #Relationships inside Notifikator
        NotifikacieController -> Osoby "Získanie e-mailových adries"
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
        TerminyDataController -> TerminyDB "Ukladá termíny; Získava info o termínoch"
        TerminyDataController -> KonfliktDetektor "Volá ohľadom kontroly termínu"
        TerminyUI -> TerminyDataController "Žiada data o termínoch"
        HlaseniNaTerminyController -> TerminyDB "Ukladá info o prihásených studentoch"
        CekaciListinaController -> TerminyDB "Ukladá info o studentoch na čakacej listine"

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
        }

        component TerminyDB "TerminyDBComponentDiagram" {
            include *
        }

        component ZnamkyManager "ZnamkyManagerComponentDiagram" {
            include *
        }

        component Notifikator "NotifikatorComponentDiagram" {
            include *
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
