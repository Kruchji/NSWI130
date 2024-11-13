workspace "SIS Exams Workspace" "Tento workspace dokumentuje architekturu systému správy zkoušek a známek v rámci Studijního informačního systému." {

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky" {
            !docs docs

            Group "Termíny zkoušek" {
                TerminyUI = container "Termíny UI" "Zobrazí UI na termíny pre učitele a študenty" "" "Web Front-End" {
                    TerminyWebApp = component "Termíny Web App" "Umožňuje interakci s termíny zkoušek"
                    TerminyUIServer = component "Termíny UI Server" "Serverová část pro zobrazování termínů zkoušek"
                }
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
                ZnamkyUI = container "Známky UI" "Zobrazí UI na známky pre učitele a študenty" "" "Web Front-End" {
                    ZnamkyWebApp = component "Známky Web App" "Umožňuje interakci se známkami"
                    ZnamkyUIServer = component "Známky UI Server" "Serverová část pro zobrazování známek"
                }
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

        # Relationships inside TerminyUI
        TerminyWebApp -> TerminyUIServer "Žádá o UI termínů zkoušek"
        TerminyWebApp -> TerminyUIServer "Posílá požadavky na změnu dat termínů"
        TerminyUIServer -> TerminyManager "Získává data o termínech"
        TerminyUIServer -> TerminyManager "Posílá žádosti o přihlášení / odhlášení / vytvoření termínu"
        manazer -> TerminyWebApp "Zobrazuje statistiky"
        student -> TerminyWebApp "Zapisuje si zkoušky"
        student -> TerminyWebApp "Čte výsledky zkoušek"
        ucitel -> TerminyWebApp "Vytváří a zobrazuje termíny"
        ucitel -> TerminyWebApp "Zobrazení termínu"
        KonfliktDetektor -> TerminyUIServer "Posiela výsledky detekcie konfliktov"
        TerminyUIServer -> Osoby "Zobrazí studenty na termínu"
        TerminyUIServer -> Osoby "Zobrazí zkoušející učitele na termínu"
        TerminyUIServer -> Predmety "Získá seznam vybraných předmětů"
        TerminyUIServer -> Predmety "Získá informace o předmětu"

        # Relationships inside ZnamkyUI
        ZnamkyWebApp -> ZnamkyUIServer "Žádá o UI známek"
        ZnamkyWebApp -> ZnamkyUIServer "Posílá požadavky na změnu známek"
        ZnamkyUIServer -> ZnamkyManager "Získává data o známkách"
        ZnamkyUIServer -> ZnamkyManager "Posílá žádosti o změny známek"
        ZnamkyUIServer -> ZnamkyManager "Pri zmene známky žiada o poslanie notifikacie"
        manazer -> ZnamkyWebApp "Zobrazuje statistiky"
        student -> ZnamkyWebApp "Čte výsledky zkoušek"
        student -> ZnamkyWebApp "Zapisuje si zkoušky"
        ucitel -> ZnamkyWebApp "Zapisuje známky"
        ucitel -> ZnamkyWebApp "Zobrazuje známky"
        ZnamkyUIServer -> Osoby "Získá informace o osobách pro zobrazení známek"
        ZnamkyUIServer -> Predmety "Získá seznam vybraných předmětů"
        ZnamkyUIServer -> Predmety "Získá informace o předmětu"

        deploymentEnvironment "Production" {
            
            deploymentNode "Školský server" "" "Multiple devices with linux"{
                deploymentNode "Termíny Managers and Analyzers" "" "Java" {
                    TerminyManagerInstance = containerInstance TerminyManager
                    
                    KonfliktDetektorInstance = containerInstance KonfliktDetektor
                }
                
                deploymentNode "Local Server" "" "Ubuntu 24.04.01 LTS"{
                    deploymentNode "Termíny DB" "" "MySQL" {
                        TerminyDBInstance = containerInstance TerminyDB
                    }
                    
                    deploymentNode "Známky DB" "" "MySQL" {
                        ZnamkyDBInstance = containerInstance ZnamkyDB
                    }
                }
                
                

                deploymentNode "Známky Managers and Analyzers" "" "Java" {
                    ZnamkyManagerInstance = containerInstance ZnamkyManager
                }
    
                deploymentNode "Notifikátor" "" "php a python" {
                    NotifikatorInstance = containerInstance Notifikator
                }
                
                deploymentNode "SIS webapp" "" "React, Node.js" {
                    TerminyUIInstance = containerInstance TerminyUI
    
                    ZnamkyUIInstance = containerInstance ZnamkyUI
                }
            }
        }

        deploymentEnvironment "Development" {
            deploymentNode "Termíny Deployment" "" "" {
                deploymentNode "Termíny UI" "" "" {
                    TerminyUIDevInstance = containerInstance TerminyUI
                }
                deploymentNode "Termíny Managers and Analyzers" "" "" {
                    deploymentNode "Termíny Manager" "" "" {
                        TerminyManagerDevInstance = containerInstance TerminyManager
                    }
                    deploymentNode "Konflikt Detektor" "" "" {
                        KonfliktDetektorDevInstance = containerInstance KonfliktDetektor
                    }
                }
            }
            
            deploymentNode "Známky Deployment" "" "" {
                deploymentNode "Známky UI" "" "" {
                    ZnamkyUIDevInstance = containerInstance ZnamkyUI
                }
                deploymentNode "Známky Managers and Analyzers" "" "" {
                    deploymentNode "Známky Manager" "" "" {
                        ZnamkyManagerDevInstance = containerInstance ZnamkyManager
                    }
                }
                
            }

            deploymentNode "Mock DB pro Známky i Termíny" "" "" {
                ZnamkyDBDevInstance = containerInstance ZnamkyDB
                TerminyDBDevInstance = containerInstance TerminyDB
            }
        }
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

        component TerminyUI "TerminyUIComponentDiagram" {
            include *
            exclude TerminyManager->KonfliktDetektor
        }

        component ZnamkyUI "ZnamkyUIComponentDiagram" {
            include *
        }

        deployment SISExams "Production" "Production" {
            include *
        }

        deployment SISExams "Development" "Development" {
            include *
        }

        dynamic SISExams {
            title "Vypsání termínu zkoušky"
            ucitel -> TerminyUI "Učitel se přihlásí do systému a vyžádá si zobrazení termínů zkoušek"
            TerminyUI -> Osoby "Získá informace o učitelovi"
            TerminyUI -> Predmety "Získá seznam předmětů pro učitele"
            TerminyUI -> TerminyManager "Požádá o data termínů zkoušek pro učitele"
            TerminyManager -> TerminyDB "Získá data o termínech zkoušek"
            TerminyManager -> TerminyUI "Pošle data o termínech zkoušek pro zobrazení"
            TerminyUI -> ucitel "Zobrazí termíny zkoušek učitelovi"
            ucitel -> TerminyUI "Učitel si vyžádá zobrazení formuláře pro nový termín zkoušky"
            TerminyUI -> ucitel "Zobrazí formulář pro nový termín zkoušky"
            ucitel -> TerminyUI "Učitel vyplní formulář s informacemi o termínu"
            TerminyUI -> TerminyManager "Pošle požadavek na vytvoření termínu zkoušky"
            TerminyManager -> KonfliktDetektor "Požádá o kontrolu konfliktů termínů zkoušek"
            KonfliktDetektor -> TerminyUI "V případě nalezení konfliktu pošle informaci o konfliktu"
            TerminyManager -> TerminyDB "Vytvoří nový termín zkoušky od učitele"
            TerminyUI -> ucitel "Zobrazí potvrzení o vytvoření termínu zkoušky"
        }

        dynamic SISExams {
            title "Zápis studenta na termín zkoušky"
            student -> TerminyUI "Student se přihlásí do systému a vyžádá si zobrazení termínů zkoušek"
            TerminyUI -> Osoby "Získá informace o studentovi"
            TerminyUI -> Predmety "Získá seznam předmětů pro studenta"
            TerminyUI -> TerminyManager "Požádá o data termínů zkoušek pro studenta"
            TerminyManager -> TerminyDB "Získá data o termínech zkoušek"
            TerminyManager -> TerminyUI "Pošle data o termínech zkoušek pro zobrazení"
            TerminyUI -> student "Zobrazí termíny zkoušek studentovi"
            student -> TerminyUI "Student může filtrovat zobrazené termíny zkoušek"
            student -> TerminyUI "Student si vybere termín zkoušky a zobrazí podrobností"
            TerminyUI -> student "Zobrazí podrobnosti o termínu zkoušky s možností zápisu"
            student -> TerminyUI "Student se zapíše na termín zkoušky"
            TerminyUI -> TerminyManager "Pošle požadavek na zápis studenta na termín zkoušky"
            TerminyManager -> KonfliktDetektor "Požádá o kontrolu konfliktů termínů zkoušek"
            KonfliktDetektor -> TerminyUI "V případě nalezení konfliktu pošle informaci o konfliktu"
            TerminyManager -> TerminyDB "Zapíše studenta na termín zkoušky"
            TerminyUI -> student "Zobrazí potvrzení o zápisu studenta na termín zkoušky"
        }

        dynamic SISExams {
            title "Zápis a zmena známky"
            ucitel -> ZnamkyUI "Učitel se přihlásí do systému a vyžádá si zobrazení seznamu studentů pro zápis známek"
            ZnamkyUI -> Predmety "Získá seznam předmětů vyučovaných učitelem"
            ZnamkyUI -> ucitel "Zobrazí seznam vyučovaných předmětů"
            ucitel -> ZnamkyUI "Vybere předmět, z kterého chce známku zapsat/změnit"
            ZnamkyUI -> ZnamkyManager "Požádá o data známek studentů z vybraného předmětu"
            ZnamkyManager -> ZnamkyDB "Získá data o aktuálních známkách studentů"
            ZnamkyManager -> ZnamkyUI "Pošle data o známkách studentů pro zobrazení"
            ZnamkyUI -> ucitel "Zobrazí seznam studentů pro zápis/změnu známek"
            ucitel -> ZnamkyUI "Učitel vybere studenta a zadá známku"
            ZnamkyUI -> ZnamkyManager "Pošle požadavek na zápis/změnu známky pro studenta"
            ZnamkyManager -> ZnamkyDB "Zapíše novou známku pro studenta"
            ZnamkyManager -> Notifikator "Pošle požadavek na notifikaci o změně známky"
            Notifikator -> ExtNotif "Posílá notifikaci studentovi o zapsané známce"
            ZnamkyUI -> ucitel "Zobrazí potvrzení o zápisu známky"
        }

        dynamic SISExams {
            title "Odhlášení studenta z termínu zkoušky"
            student -> TerminyUI "Student se přihlásí do systému a vyžádá si zobrazení svých termínů zkoušek"
            TerminyUI -> TerminyManager "Požádá o data termínů zkoušek, na které je student přihlášený"
            TerminyManager -> TerminyDB "Získá data o termínech zkoušek"
            TerminyManager -> TerminyUI "Pošle data o termínech zkoušek pro zobrazení"
            TerminyUI -> student "Zobrazí termíny zkoušek studentovi"
            student -> TerminyUI "Student si vybere termín zkoušky a zobrazí podrobností"
            TerminyUI -> student "Zobrazí podrobnosti o termínu zkoušky s možností odhlášení"
            student -> TerminyUI "Student se odhlásí z termínu zkoušky"
            TerminyUI -> TerminyManager "Pošle požadavek na odhlášení studenta z termínu zkoušky"
            TerminyManager -> TerminyDB "Odhlásí studenta z termínu zkoušky"
            TerminyUI -> student "Zobrazí potvrzení o odhlášení studenta z termínu zkoušky"
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
