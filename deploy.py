import os

from fabric import task, Connection
from dotenv import load_dotenv

# Read environment variables
load_dotenv()


# Connect to the remote machine
c = Connection(host=os.environ.get('SERVER_HOST'), user=os.environ.get('SERVER_USER'), 
               port=22, connect_kwargs={
                  "key_filename": os.environ.get('SECRET_KEY_FILENAME'),
                  "password": os.environ.get('SECRET_KEY_PASSWORD')
               })


# Pull the latest code and rebuild the docker containers
with c.cd('Codebrew2020'):
    c.run('git pull', pty=True)
    c.run('docker stop $(docker ps -aq)')
    c.run('docker-compose -f docker-compose.yml up --build -d')
