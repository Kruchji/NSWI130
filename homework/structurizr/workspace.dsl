workspace "SIS Exams Workspace" "Tento workspace dokumentuje architekturu systému správy zkoušek a známek v rámci Studijního informačního systému." {

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky" {
            TerminyUI = container "Termíny UI" "" "" "Web Front-End"
            ZnamkyUI = container "Známky UI" "" "" "Web Front-End"
            TerminyManager = container "Termíny Manager"
            TerminyDB = container "TermínyDB" "" "" "Database"
            KonfliktDetektor = container "Konflikt Detektor"
            ZnamkyManager = container "Známky Manager"
            ZnamkyDB = container "Známky DB" "" "" "Database"
            Osoby = container "Osoby" "" "" "Existing System"
            Predmety = container "Predmety" "" "" "Existing System"
            Notifikator = container "Notifikator"
            ExtNotif = container "Ext. notif." "" "" "Existing System"
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
                shape Cylinder
            }
            element "Web Front-End" {
                shape WebBrowser
            }
        }
    }

}