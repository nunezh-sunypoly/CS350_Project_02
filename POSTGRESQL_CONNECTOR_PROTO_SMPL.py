from dotenv import load_dotenv
import os

#   GET APPLICATION ENVIROMENT VARIABLES
load_dotenv()
hostname    =   os.getenv("HOST_NAME")
database    =   os.getenv("DATABASE")
username    =   os.getenv("USER_NAME")
pwd         =   os.getenv("PWD")
port        =   os.getenv("PORT")