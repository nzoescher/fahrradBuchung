from datetime import datetime
from sqlmodel import SQLModel, Field, Relationship

class Gast(SQLModel):
    vorname: str
    nachname: str
    grosse: int

class Fahrrad(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    typ: str
    grosse: str
    besetzt: bool = False

    buchungen: list["Booking"] = Relationship(back_populates="fahrrad")

class Tour(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    tourname: str
    startzeitpunkt: datetime
    endzeitpunkt: datetime

    buchungen: list["Booking"] = Relationship(back_populates="tour")

class Booking(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)

    gast_vorname: str
    gast_nachname: str
    gast_grosse: int

    # Rad verknüpfen
    fahrrad_id: int = Field(foreign_key="fahrrad.id")
    fahrrad: Fahrrad | None = Relationship(back_populates="buchungen")

    # Tour verknüpfen
    tour_id: int = Field(foreign_key="tour.id")
    tour: Tour | None = Relationship(back_populates="buchungen")