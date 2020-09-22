# Codebrew2020

### Description

Working application is hosted at [http://165.22.254.55](http://165.22.254.55)

### Development Guide

1. Install Docker. See this [link](https://docs.docker.com/docker-for-mac/install/) for installation guide on Mac OS.
2. Set the working directory to this repo `$ cd codebrew2020`.
3. Create a `.env` file and add the necessary environment variables. See `.env.example` for example.
4. Also create a `.env` file in the `client` folder. See `./client/.env.example`
5. Run the development server and web app by running this command: `$ docker-compose -f dev-docker-compose.yml up --build`
6. The web app and server will be available based on your chosen ports.

### Production Guide

Build the production version by running this command `docker-compose -f docker-compose.yml up --build -d`.