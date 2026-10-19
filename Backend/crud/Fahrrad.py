from sqlmodel import Session, select
from Backend import Groessenwaehler
from Backend.DatenbankInit import engine
from Backend.models import Fahrrad, Gast


def add_fahrrad(session : Session, fahrrad : Fahrrad) -> Fahrrad:
    session.add(fahrrad)
    session.commit()
    session.refresh(fahrrad)
    return fahrrad

def delete_fahrrad(session : Session, fahrrad_id : int) -> bool:
    gast = session.get(Fahrrad, fahrrad_id)
    session.delete(gast)
    session.commit()
    return True

def finde_passendes_groesse(gast : Gast, typ : Groessenwaehler.RadTyp) -> str | int:
    gast_grosse = gast.grosse
    grossen = Groessenwaehler.GROESSEN_TABELLE
    moglichkeiten = []

    for radtyp, intervalle in grossen.items():
        if radtyp.value == typ.value:
            moglichkeiten = intervalle

    for moglichkeit in moglichkeiten:
        if moglichkeit[0] <= gast_grosse <= moglichkeit[1]:
            return moglichkeit[2]

    raise ValueError("Es existiert keine passende Größe")


def weise_passendes_rad_zu(gast : Gast, typ : Groessenwaehler.RadTyp) -> Fahrrad:
    ziel_grosse = finde_passendes_groesse(gast, typ)

    with Session(engine) as session:
        statement = select(Fahrrad).where(Fahrrad.typ == typ.value).where(Fahrrad.grosse == ziel_grosse).where(Fahrrad.besetzt==False)
        result = session.exec(statement).first()

        if result:
            return result

    raise ValueError("Kein passendes Rad gefunden")

