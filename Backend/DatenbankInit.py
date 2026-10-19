from sqlmodel import SQLModel, create_engine, Session

engine = create_engine("sqlite:///database.db", echo=True)

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)

if __name__ == "__main__":
    create_db_and_tables()