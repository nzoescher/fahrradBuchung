from fastapi import FastAPI
import uvicorn
from sqlmodel import Session
from starlette.middleware.cors import CORSMiddleware

from DatenbankInit import engine
from crud.Tour import get_all_tours, add_tour, delete_tour, get_tourParticipants
from models import Tour

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def read_tours()-> None:
    with Session(engine) as session:
        tours = get_all_tours(session=session)
        return tours

@app.get("/tour/{tour_id}")
async def read_tour(tour_id : int):
    with Session(engine) as session:
        bookingsForTour = get_tourParticipants(session = session, tour_id= tour_id)
        return bookingsForTour

@app.post("/")
async def create_tour(tour : Tour) -> None:
    with Session(engine) as session:
        await add_tour(session = session, tour = tour)

@app.delete("/tours/{tour_id}")
async def remove_tour(tour_id: int) -> None:
    with Session(engine) as session:
        await delete_tour(session=session, tour_id=tour_id)

if __name__ == "__main__":
    uvicorn.run("api:app", host="127.0.0.1", port=8000, reload=True)