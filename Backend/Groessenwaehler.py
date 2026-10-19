from enum import Enum

class RadTyp(Enum):
    E_MOUNTAINBIKE_HARDTAIL = "E-Mountainbike Hardtail"
    E_MOUNTAINBIKE_FULLY = "E-Mountainbike Fully"
    GRAVELBIKE = "Gravelbike"
    RENNRAD_CUBE = "Rennrad Cube"
    MOUNTAINBIKE_HARDTAIL = "Mountainbike-Hardtail"
    MOUNTAINBIKE_FULLY = "Mountainbike-Fully"
    E_CITYBIKE = "E-Citybike"
    E_KINDERBIKE = "E-Kinderbike"
    KINDERBIKE = "Kinderbike"
    TREKKINGBIKE = "Trekkingbike"


GROESSEN_TABELLE = {

    RadTyp.TREKKINGBIKE: [
        (150,165,16),
        (165, 170, 17),
        (171, 180, 19),
        (181, 190, 21),
        (191, 205, 23)
    ],

    RadTyp.E_CITYBIKE: [
        (150,165,16),
        (165, 170, 17),
        (171, 180, 19),
        (181, 190, 21),
        (191, 205, 23)
    ],

    RadTyp.MOUNTAINBIKE_FULLY: [
        (150,165,16),
        (165, 170, 17),
        (171, 180, 19),
        (181, 190, 21),
        (191, 205, 23)
    ],

    RadTyp.MOUNTAINBIKE_HARDTAIL: [
        (150,165,16),
        (165, 170, 17),
        (171, 180, 19),
        (181, 190, 21),
        (191, 205, 23)
    ],

    RadTyp.GRAVELBIKE: [
        (160, 170, "S"),
        (171, 180, "M"),
        (181, 190, "L"),
        (191, 205, "XL")
    ],

    RadTyp.E_MOUNTAINBIKE_HARDTAIL: [
        (150,165,16),
        (165, 170, 17),
        (171, 180, 19),
        (181, 190, 21),
        (191, 205, 23)
    ],
    RadTyp.E_MOUNTAINBIKE_FULLY: [
        (150, 169, 16),
        (170, 179, 18),
        (180, 189, 20),
        (190, 200, 22)
    ],
    RadTyp.RENNRAD_CUBE: [
        (150, 164, 50),
        (165, 169, 52),
        (170, 174, 53),
        (175, 182, 56),
        (183, 190, 58),
        (191, 200, 60)
    ],
    RadTyp.KINDERBIKE: [
        (100, 115, 16),
        (116, 124, 20),
        (125, 139, 24),
        (140, 150, 26)
    ],
    RadTyp.E_KINDERBIKE: [
        (100, 115, 16),
        (116, 124, 20),
        (125, 139, 24),
        (140, 150, 26)
    ]
}




