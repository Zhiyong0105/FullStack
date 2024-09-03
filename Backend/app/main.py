# from database import engine, SessionLocal
# from models import Base
# import crud as crud

from database import engine, SessionLocal
from models import Base
import crud as crud


def main():
    # Base.metadata.create_all(bind=engine)
    # db = SessionLocal()
    # try:
    #     user = crud.create_user(db, id="1234",displayed_name="pp")
    #     if user:
    #         print(f'User created: {user}')
    #     else:
    #         print('Failed to create user')
    # except Exception as e:
    #     print(f'An error occurred: {e}')
    # finally:
    #     db.close()
    print("text")


if __name__ == "__main__":
    main()
