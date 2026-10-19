from datetime import datetime
from sqlmodel import Session, select
from models import Tour, Fahrrad, Gast, Booking


async def add_tour(session : Session, tour : Tour) -> Tour:

    if isinstance(tour.startzeitpunkt, str):
        tour.startzeitpunkt = datetime.fromisoformat(tour.startzeitpunkt)

    if isinstance(tour.endzeitpunkt, str):
        tour.endzeitpunkt = datetime.fromisoformat(tour.endzeitpunkt)

    session.add(tour)
    session.commit()
    session.refresh(tour)
    return tour

async def delete_tour(session : Session, tour_id : int) -> None:
    tour = session.get(Tour, tour_id)
    session.delete(tour)
    session.commit()


def add_booking(session : Session, gast_id : int, fahrrad_id: int) -> bool:

    rad = session.get(Fahrrad, fahrrad_id)
    gast = session.get(Gast, gast_id)

    if not rad or not gast:
        raise ValueError("Rad oder Gast existiert nicht")

    rad.besetzt = True

    booking = Booking(gast_id=gast_id, fahrrad_id=fahrrad_id)
    session.add(booking)
    session.commit()
    return True

def delete_booking(session : Session, booking_id : Booking)-> None:
    booking = session.get(Booking, booking_id)
    session.delete(booking)
    session.commit()
    
def get_tourParticipants(session : Session, tour_id : int) -> list[Booking]:
    fittingBookings : list[Booking] = []

    statement = select(Booking)
    result : list[Booking] = session.exec(statement).all()

    for booking in result:
        if booking.tour_id == tour_id:
            fittingBookings.append(booking)

    return fittingBookings

def get_all_tours(session : Session):
    statement = select(Tour)
    result = session.exec(statement).all()
    return result







