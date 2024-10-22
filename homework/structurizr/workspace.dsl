workspace "Name" "Description" {

    !identifiers hierarchical

    model {
        # SW Systems
        SISExams = softwareSystem "Zkoušky v rámci SIS" "Spravuje vytvareni zkousek, zapis studentu a monitoruje jejich vysledky"

        SIS = softwareSystem "SIS" "Spravuje data veci, co se dejou na univerzite. Vcetne zkousek, predmetu a zapisu."

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
    }

    views {
        systemContext SISExams "SISExamsDiagram" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                background #9b191f
                shape person
            }
            element "Software System" {
                background #ba1e25
            }
            element "Container" {
                background #d9232b
            }
                element "Database" {
                shape cylinder
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}