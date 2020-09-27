# OpenRecipe

### Description

From cart to kitchen - OpenRecipe makes your food journey more seamless, affordable and healthy than ever. Customize your meal plans on a budget by finding the best recipes with latest sale items from your local supermarket.

DISCLAIMER: our recipe data comes from [BBC Goodfood](https://www.bbcgoodfood.com/).

### Dependencies
Python 3.7.4, Flutter

### Development Guide

1. Install Docker. See this [link](https://docs.docker.com/docker-for-mac/install/) for installation guide on Mac OS.
2. Set the working directory to this repo `$ cd Codebrew2020`.
3. Create a `.env` file and add the necessary environment variables. See `.env.example` for example.
4. Run the development server and web app by running this command: `$ docker-compose -f dev-docker-compose.yml up --build`
5. The DB instance and server will be available based on your chosen ports.

### Production Guide

1. Install [fabric](http://www.fabfile.org/)
2. Run the deployment script on the outermost of this repository: `$ python deploy.py`


### Backend Development

When you need to install third-party libraries for the backend, follow these steps:
1. Go to the server folder: `$ cd server`
2. If haven't got a virtual environment, create one: `$ virtualenv venv --python=python3.7`
3. Activate the virtual environment: `$ source venv/bin/activate`
4. Install the library using: `$ pip install <library_name>`
5. CRUCIAL: Update `requirements.txt` using: `$ pip freeze > requirements.txt`


### Frontend Development
Mobile app related code is in the `recipe` directory.