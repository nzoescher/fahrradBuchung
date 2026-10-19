from sqlmodel import Session
from sqlmodel.orm import session
from DatenbankInit import engine
from crud.Tour import get_all_tours
from crud import Tour

if __name__ == "__main__":
    # WICHTIG: Session(engine) mit großem 'S' öffnet die echte Verbindung!
    with Session(engine) as session:
        tours = get_all_tours(session=session)
        print("Ergebnis:", tours)
