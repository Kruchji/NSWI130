workspace "SIS Exams Workspace" "Tento workspace dokumentuje architekturu systému správy zkoušek a známek v rámci Studijního informačního systému." {

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky" {
            TerminyUI = container "Termíny UI" "Zobrazí UI na termíny pre učitele a študenty" "" "Web Front-End"
            ZnamkyUI = container "Známky UI" "Zobrazí UI na známky pre učitele a študenty" "" "Web Front-End"
            TerminyManager = container "Termíny Manager" "Rieši veci okolo termínov (vnútorné členenie na minimálne čakačku a prihlasovanie); posiela notifikácie pri zmenách; komunikuje s DB"
            TerminyDB = container "TermínyDB" "Ukladá info o termínoch, prihlásených studentech, čakajúcich studentech" "" "Database"
            KonfliktDetektor = container "Konflikt Detektor" "Volá ho termíny manager, detekuje konflikty, reportuje stav termíny UI"
            ZnamkyManager = container "Známky Manager" "Rieši veci okolo známok (zapisovanie, pozeranie, ...); posiela notifikácie pri zmenách; treba spojeni so známky managerom pre prípad, že termín vyžaduje zápočet; kounikuje s DB"
            ZnamkyDB = container "Známky DB" "Ukladá hodnotenie št aj s históriou v rámci jedného predmetu" "" "Database"
            Osoby = container "Osoby" "Externí modul pre osoby (extra info o nich, ...)" "" "Existing System"
            Predmety = container "Predmety" "Externí modul pre predmety (aktuálne zapísané pre študenty, história, ...)" "" "Existing System"
            Notifikator = container "Notifikator" "Vytvára notifikácie (po obsahovej stránke čiže nejaké templaty); emaily, notifikácie do UI; (umožnění učitelům upravit obsah => treba napojiť na UI)"
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

        # Relationships between SW Systems
        SISExams -> SIS "API na zistení a zápis dat"

        # Relationships inside SISExams
        TerminyUI -> TerminyManager
        TerminyManager -> TerminyDB
        KonfliktDetektor -> TerminyUI
        KonfliktDetektor -> TerminyDB
        TerminyManager -> KonfliktDetektor
        TerminyManager -> Notifikator
        TerminyUI -> Osoby
        TerminyUI -> Predmety
        ZnamkyUI -> ZnamkyManager
        ZNamkyUI -> Osoby
        ZnamkyUI -> Predmety
        ZnamkyManager -> ZnamkyDB
        ZnamkyManager -> Notifikator
        Notifikator -> ExtNotif
    }

    views {
        systemContext SISExams "SISExamsSystemDiagram" {
            include *
        }

        container SISExams "SISExamsContainerDiagram" {
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