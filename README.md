# README

Api excercise to Reservamos.com

## Setup

1. Install dependencies:

   ```bash
    bundle install
   ```

2. Run Server:

   ```bash
   rails server
   ```

## Docker Setup(live reload)

1. Build the Docker containers:

   ```bash
    docker-compose build
   ```

2. Start the Docker containers:

   ```bash
     docker-compose up
   ```

3. If there are new gems, install them inside the web container:

   ```bash
     docker-compose exec web bundle install
   ```

## Api

Access the API at [http://localhost:3000](http://localhost:3000) or the relevant URL.

- [http://localhost:3000/health](http://localhost:3000/health) is for checking the server status.

- [http://localhost:3000/weather_by_place](http://localhost:3000/weather_by_place) retrieves places with their weather.

- [http://localhost:3000/weather_by_place?query=monterrey](http://localhost:3000/weather_by_place?query=monterrey) retrieves specific places with their weather.
